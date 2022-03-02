# Helm Push to GCS Github Action

## Inputs

### chart-path

**Required** - The relative path to the helm chart to push

*Example* - `deployments/my-super-awesome-chart`

### gcs-bucket

**Required** - The GCS bucket (and optional sub-path) to push to

*Example* - `gs://charts.mysuperawesomeproject.io/stable/thing`

### google-credentials

**Required** - You Google GCP credentials.json file that allows access to the specified bucket

*Example* - `Yeah, i'm not putting an example creds.json here`

## Outputs

### output

The command output

## Example usage

```yaml
uses: sixgill/actions-helm-push-artifactory
with:
  chart-path: deployments/my-super-awesome-chart
  gcs-bucket: gs://charts.plainsight.ai/testing/edge
  google-credentials: ${{ secrets.GOOGLE_CREDENTIALS }}
```