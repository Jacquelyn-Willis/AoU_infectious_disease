
#!/usr/bin/env bash
set -euo pipefail

# Use REGENIE from your conda env (no need to activate)
export PATH="$HOME/.conda/envs/regenie4/bin:$PATH"


# Show which regenie we will use (sanity check)
echo "Using regenie at: $(which regenie)"


# Local paths

PLINK1="/home/jupyter/workspaces/infectiousdiseasephewas2/results/2026-02-18_validate_regenie_pipeline_by_replicating_AoU_gwas_results/acaf_step1_regenie"     # prefix only (has .bed/.bim/.fam)

PLINK2="/home/jupyter/workspaces/infectiousdiseasephewas2/data/2026-02-18_validate_regenie_pipeline_by_replicating_AoU_gwas_results/acaf_v7_plink_files/acaf_threshold.chr16"       # prefix only (has .bed/.bim/.fam)


MERGED_TSV='/home/jupyter/workspaces/infectiousdiseasephewas2/results/2026-02-18_validate_regenie_pipeline_by_replicating_AoU_gwas_results/lupus_matched_ALL.regenie.mapped.txt'        # columns: FID IID meningitis sex age

MERGED_TSV2='/home/jupyter/workspaces/infectiousdiseasephewas2/results/2026-02-18_validate_regenie_pipeline_by_replicating_AoU_gwas_results/lupus_matched_ALL.regenie.mapped.txt'        # columns: FID IID meningitis sex age

OUT_DIR='/home/jupyter/workspaces/infectiousdiseasephewas2/results/2026-02-18_validate_regenie_pipeline_by_replicating_AoU_gwas_results/regenie_results'

#mkdir -p "$OUT_DIR"


# STEP 2 — single-variant aasoc. test
regenie \
  --step 2 \
  --bed "${PLINK2}" \
  --bt --loocv \
  --phenoFile "${MERGED_TSV2}" \
  --phenoCol case \
  --covarFile  "${MERGED_TSV2}" \
  --covarColList sex,age,age2,age_sex,age2_sex,PC{1:16} \
  --pred "${OUT_DIR}/lupus_all_fit_step1_pred.list" \
  --bsize 500 \
  --threads 16 \
  --out "${OUT_DIR}/lupus_all_assoc"

