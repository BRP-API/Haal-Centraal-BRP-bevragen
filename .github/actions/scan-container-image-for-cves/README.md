# Container Image scannen op CVE's en genereren van SBOM met Trivy

Een GitHub Action voor het scannen van een container image op CVE's met behulp van Trivy, het genereren van een SBOM en het uploaden van de rapporten als artefact.

## Gebruik

```yaml
- name: Container Image scannen op CVE's en genereren van SBOM
  uses: ./.github/actions/scan-container-image-for-cves
  with:
    image: 'ghcr.io/brp-api/my-image:latest'
    trivy-version: 'v0.70.0'
    severity: 'CRITICAL,HIGH'
```

## Input

| Parameter | Beschrijving | Vereist | Standaard |
|-------|-------------|---------|----------|
| `image` | Container image die moet worden gescand | Ja | |
| `trivy-version` | Versie van Trivy die moet worden gebruikt | Nee | `v0.70.0` |
| `severity` | Door komma's gescheiden lijst met ernstniveaus (bijv. CRITICAL,HIGH) | Nee | `CRITICAL,HIGH` |
| `artifact-name` | Naam voor het trivy scan rapport (zonder extensie) | Nee | `trivy-image-report` |

## Wat doet deze action

1. Scant een container image met behulp van Trivy op kwetsbaarheden
2. Schrijft het scanresultaat weg in JSON formaat
3. Converteert het scanresultaat in JSON formaat naar een tabel variant
4. Publiceert het scanresultaat in tabel formaat naar de workflow job summary
5. Genereert een SBOM van de container image in CycloneDX JSON formaat
6. Uploadt alle rapporten als workflow artefacten

## Artefacten

De action uploadt altijd de volgende rapporten als artefacten (ook als er kwetsbaarheden worden gevonden):
- `${{ inputs.artifact-name }}.json` - CVE-scanrapport in JSON formaat
- `${{ inputs.artifact-name }}.txt` - CVE-scanrapport in leesbaar tabel formaat
- `${{ inputs.artifact-name }}-sbom.cdx.json` - SBOM van de container image in CycloneDX JSON formaat
