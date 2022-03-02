# Helm Push to GCS Github Action

## Inputs

### chart-path

**Required** - The relative path to the helm chart to push

*Example* - `deployments/my-super-awesome-chart`

### gcs-bucket

**Required** - The GCS bucket (and optional sub-path) to push to

*Example* - `gs://charts.mysuperawesomeproject.io/stable/thing`

### google-credentials

**Required** - Your Google GCP credentials.json file that allows access to the specified bucket

*Example* - `Yeah, i'm not putting an example b64 creds.json here`

### chart-url

The URL to assign to the chart in question.

*Example* - `https://charts.mysuperawesomeproject.io/stable/thing`

## Outputs

### output

The command output

## Example usage

```yaml
uses: sixgill/actions-helm-push-artifactory
with:
  chart-path: deployments/my-super-awesome-chart
  chart-url: https://charts.plainsight.ai
  gcs-bucket: gs://charts.plainsight.ai/testing/edge
  google-credentials: ${{ secrets.GOOGLE_CREDENTIALS }}
```