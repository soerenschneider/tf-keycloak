package test

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/docker"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

const (
	vaultUrl   = "http://localhost:8200"
	vaultToken = "test"
	vaultPath  = "secret/data/env/dev/keycloak/test/clients/%s"
)

func TestTerragrunt(t *testing.T) {
	workDir := "../envs/dev"
	dockerOpts := &docker.Options{
		WorkingDir: workDir,
		EnvVars: map[string]string{
			"COMPOSE_FILE": "docker-compose.yaml",
		},
	}

	_ = os.Remove(workDir + "/terraform.tfstate")

	defer docker.RunDockerCompose(t, dockerOpts, "down")
	docker.RunDockerCompose(t, dockerOpts, "up", "-d")

	waitForVault(t)
	waitForHttp(t, "http://localhost:8080")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir:    workDir,
		TerraformBinary: "terragrunt",
		EnvVars: map[string]string{
			"TF_ENCRYPTION": `key_provider "pbkdf2" "mykey" {passphrase = "somekeynotverysecure"}`,
		},
	})

	defer terraform.Destroy(t, terraformOptions)
	terraform.Apply(t, terraformOptions)

	secret, err := readVaultSecret(vaultUrl, vaultToken, fmt.Sprintf(vaultPath, "grafana"))
	assert.NoError(t, err)
	assert.Contains(t, secret, "client_id")
	assert.Contains(t, secret, "secret_id")
}

func readVaultSecret(vaultAddr, token, secretPath string) (map[string]interface{}, error) {
	url := fmt.Sprintf("%s/v1/%s", vaultAddr, secretPath)

	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %v", err)
	}

	req.Header.Set("X-Vault-Token", token)
	client := &http.Client{
		Timeout: 1 * time.Second,
	}
	resp, err := client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to send request: %v", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("unexpected response status: %s", resp.Status)
	}
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to read response body: %v", err)
	}

	var responseData map[string]interface{}
	if err := json.Unmarshal(body, &responseData); err != nil {
		return nil, fmt.Errorf("failed to parse JSON response: %v", err)
	}

	data, ok := responseData["data"].(map[string]interface{})
	if !ok {
		return nil, fmt.Errorf("unexpected response structure")
	}

	secretData, ok := data["data"].(map[string]interface{})
	if !ok {
		return nil, fmt.Errorf("unexpected secret data structure")
	}

	return secretData, nil
}

func waitForVault(t *testing.T) {
	retry.DoWithRetry(t, "Waiting for vault service", 45, 1*time.Second, func() (string, error) {
		resp, err := http.Get(vaultUrl + "/ui/")
		if err != nil {
			return "", err
		}
		defer resp.Body.Close()

		if resp.StatusCode != 200 {
			return "", fmt.Errorf("expected HTTP status 200 but got %d", resp.StatusCode)
		}

		return "Service is available", nil
	})
}

func waitForHttp(t *testing.T, addr string) {
	retry.DoWithRetry(t, "Waiting for http service", 45, 1*time.Second, func() (string, error) {
		resp, err := http.Get(addr)
		if err != nil {
			return "", err
		}
		defer resp.Body.Close()

		if resp.StatusCode != 200 {
			return "", fmt.Errorf("expected HTTP status 200 but got %d", resp.StatusCode)
		}

		return fmt.Sprintf("Service at %s is available", addr), nil
	})
}
