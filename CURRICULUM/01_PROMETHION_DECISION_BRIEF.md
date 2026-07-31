# PromethION Procurement Decision Brief + Long-Read Curriculum Refocus
Date: 2026-07-27 · Prepared for: ISO 17025 microbiology laboratory considering ONT PromethION

---

## 1. SOURCE REVIEW — five ONT resources

**Access note:** 3 of the 5 ONT pages are landing pages; the substantive data sits in gated PDFs
behind a download form. Figures below marked **[ONT]** came from the accessible page text;
figures marked **[LIT]** were supplied from peer-reviewed primary literature to fill the gap.
Download the gated PDFs yourself for the citable versions.

### R1 — Combating viral contamination and disease outbreaks at source **[ONT, good detail]**
- **HBV case:** 148 HBV+ clinical samples; ~3.2 kb genome; multiplexed tiled PCR; **GridION**.
  **96 samples sequenced in 14 hours.** 123/148 samples ≥80 % uniform coverage at **>2,300×**.
  Genotyping (A–J), A/D recombination detection, drug- and vaccine-resistance mutation profiling.
- **Astrovirus case:** 134 mollusc samples (shellfish, coastal); targeted nested RT-PCR;
  37 AstV contigs; avian/bat/reptilian AstV detected; no human AstV. Interpreted as faecal/
  environmental contamination signal.
- **Claim:** long reads span whole RT-PCR amplicons → resolves mixed/quasispecies populations
  Sanger cannot.
- **Relevance:** amplicon virology on a GridION is high-throughput and cheap. This does **not**
  require a PromethION.

### R2 — Superior MAG recovery and strain-level resolution from a complex microbiome **[gated]**
Landing page only: human gut microbiome, ONT vs other platforms, benchmarking data in PDF.
**[LIT] substitutes:**
- PromethION 1 Tbp long-read + 0.9 Tbp short-read across 23 wastewater treatment plants →
  **1,083 high-quality MAGs incl. 57 closed circular genomes** (Singleton et al., *Nat Commun* 2021).
- Long-read-only metagenomics: **275 MAGs, 94 high-quality with full-length rRNA operons**
  (Sereika/Kirkegaard, *Microbiome* 2022).
- Hybrid long+short recovers **~2× more mid-to-high-quality MAGs** than Illumina-only.
- Caveat found in the literature: at *low depth* ONT-only can underperform Illumina for HQ MAG
  count (one time-series study: Illumina 57 HQ MAGs vs ONT 14). **Depth is the deciding variable** —
  which is precisely the PromethION argument.

### R3 — Nanopore whole-genome sequencing of foodborne pathogens **[gated]**
Landing page confirms only: MinION/GridION, MinION Flow Cells, EPI2ME analysis platform,
closed microbial genome assemblies from nanopore reads alone thanks to improved ML basecalling.
**[LIT] substitutes** — see R4.

### R4 — High-quality, low-cost, nanopore-only bacterial genome sequences **[ONT partial + LIT]**
- **[ONT]** Kit 14 + R10.4.1; **40× coverage yields near-finished genomes with no polishing**;
  short-read polishing gave **no significant improvement**. *M. tuberculosis*: **>99.99 %
  concordance with Illumina** for SNVs and indels (151 matched isolate pairs).
- **[ONT benchmarking blog]** 14 Gram-positive and Gram-negative species, R10.4.1 on MinION/
  GridION; models fast/hac/sup; **SUP + duplex = median read accuracy 99.93 % (Q32)**;
  7 variant callers assessed — **Clair3 and DeepVariant highest F1** for SNPs and indels;
  nanopore beat short-read Snippy especially in repetitive and variant-dense regions;
  SUP+Clair3 false-indel rate matched the short-read method.
- **[LIT] Hall et al., *Microbial Genomics* 2024** (the definitive costing study):
  - R10.4.1/Kit 14 at 5 kHz; Dorado v0.4.0 vs v0.5.3 (methylation-aware); vs R9.4.1 baseline.
  - Read accuracy: **R10.4.1 median 98.8 % (IQR 98.1–99.2)** vs **R9.4.1 96.8 %** (P<0.001).
  - Flye v2.9 (`--nano-hq`) + **one round of Medaka** — further polishing rounds gave no gain.
  - **≥40× depth → assemblies comparable to or better than hybrid Unicycler gold standard**
    (lower error than hybrid in 3 of 4 species).
  - CDS recovery **>99 % at ≥30×**.
  - **BSA in the library** improved per-read identity 98.76 % → 99.32 % (P<0.001).
  - **Cost: ~£1,200 per MinION/GridION flow cell yielding ~5.9–6.4 Gb (rapid kit) → £40–45
    per isolate at 40×.**
  - Verdict: *"reference quality genome assembly without the need for short-read sequencing."*

### R5 — Culture-free strain-level characterisation of foodborne pathogens using targeted nanopore metagenomics **[ONT, good detail]**
- *Staphylococcus aureus* (outbreak strain) spiked into **mashed potato**; potato+pathogen DNA mixes.
- **Adaptive sampling on GridION**, three strategies: (a) deplete potato DNA, (b) enrich *S. aureus*,
  (c) enrich against a foodborne-pathogen database. Compared with untargeted shotgun.
- Enterotoxin gene recovery (13 genes): **potato-depletion 13/13; S. aureus enrichment 13/13;
  pathogen-DB enrichment 11/13 (85 %); untargeted shotgun 8/13 (62 %) and 11/13 (85 %)**.
- Strain placed correctly within the outbreak phylogenetic cluster.
- **No culture enrichment step.** Conclusion: adaptive sampling outperformed shotgun for
  outbreak investigation.

---

## 2. WHAT THE FIVE COLLECTIVELY ESTABLISH

1. **Nanopore-only is now the reference method for bacterial isolate WGS.** ≥40× on R10.4.1/Kit 14
   with Dorado SUP + Flye + one Medaka round equals or beats hybrid assembly. Illumina is no
   longer required for a closed, accreditable bacterial genome. (R3, R4)
2. **£40–45 / isolate all-in on a MinION flow cell**, before labour. This is the number to put in
   your business case. (R4)
3. **Adaptive sampling is the killer application for food microbiology** — it removes the culture
   enrichment step, which is the rate-limiting stage of every ISO food method you currently run.
   (R5)
4. **Metagenomics is where depth — and therefore PromethION — actually matters.** Isolate WGS does
   not need a PromethION. Complex-matrix metagenomics does. (R2)
5. **Amplicon/viral work is a GridION-scale job**, 96 samples in 14 h. (R1)

---

## 3. PROMETHION DECISION

### Throughput arithmetic (bacterial isolate WGS, 5 Mb genome, 40× target)

| | Per-isolate data need | Realistic FC yield | Isolates / FC | ~FC cost | Cost / isolate |
|---|---|---|---|---|---|
| Flongle FLO-FLG114 | 0.25–0.5 Gb | 1–2 Gb | 2–4 | ~$90 | high, but ideal for singletons |
| MinION FLO-MIN114 | 0.25–0.5 Gb | 6–25 Gb | 12–24 (typical) | ~$500–900 | **£40–45 [LIT]** |
| PromethION FLO-PRO114M | 0.25–0.5 Gb | 80–150 Gb (up to ~200) | **96 (barcode-limited)** | ~$1,600–2,000 | **~$20–25** |

**Conclusion:** PromethION halves per-isolate cost — *but only if you fill a flow cell with 96
barcodes in one batch.* Below ~48 isolates per run you are paying more per isolate than a GridION.

### Where PromethION is genuinely justified

| Driver | Justifies PromethION? |
|---|---|
| ≥96 bacterial isolates per batch, routinely | **Yes** |
| Shotgun metagenomics on food matrices, wastewater, clinical specimens (10–50 Gb/sample) | **Yes — strongest driver** |
| Culture-free targeted metagenomics with adaptive sampling at scale | **Yes** |
| MAG recovery from complex communities (R2) | **Yes** |
| 5–20 isolates/week routine food or clinical typing | **No — GridION** |
| Viral amplicon panels, 96-plex | **No — GridION** |
| Occasional / on-demand single isolates | **No — MinION + Flongle** |

### Configuration guidance

| Config | Positions | Compute | ISO 17025 note |
|---|---|---|---|
| **P2 Solo** | 2 | **Host PC you must supply and spec** (high-end GPU mandatory for SUP basecalling) | You own qualification of the compute. Heavier validation burden. |
| **P2i** | 2 | **Integrated GPU compute** | Vendor-integrated = far easier to qualify as a single item of equipment |
| **P24 / P48** | 24 / 48 | Integrated | Only for genuine population-scale programmes |
| GridION | 5 MinION FCs | Integrated GPU | The realistic default for a food/clinical micro lab |

**My recommendation, subject to your batch sizes:** **P2i, not P2 Solo** — the integrated compute
is worth the premium because under ISO 17025 §6.4 (equipment) and §7.11 (data and information
management) a vendor-qualified integrated unit is one equipment record instead of a
self-built server you must specify, qualify, patch-control and revalidate. If your volumes are
under ~50 isolates/batch and you are not doing shotgun metagenomics, buy a **GridION** instead
and revisit PromethION in 18 months.

**Do not buy P2 Solo unless you already have a validated GPU server and a person who owns it.**

### Hidden costs to put in the business case
- GPU compute for Dorado SUP (P2 Solo only): RTX 4090/5090-class or A6000, plus UPS.
- Storage: POD5 raw signal is ~1.5–3 TB per full PromethION flow cell. Budget 50–100 TB usable
  plus an archive tier. **ISO 17025 §7.5/§7.11 requires you to define retention for raw data —
  decide now whether you retain POD5 or only FASTQ/BAM.** This is a real six-figure decision.
- Network: PromethION generates data faster than a 1 GbE link can move it.
- Cold-chain and shelf life on flow cells and Kit 14 reagents — flow cells expire; unfilled
  capacity is money burned.
- A second person trained on the instrument (single-point-of-failure finding at assessment).

---

## 4. CURRICULUM REFOCUS — long-read / ONT-first

Short-read content is demoted to a named legacy comparator throughout. Revised weights:

| # | Module | Old h | **New h** | Change |
|---|---|---|---|---|
| 0 | Roadmap | 4 | 4 | — |
| 1 | Molecular biology for NGS | 12 | **10** | trimmed; HMW DNA integrity added |
| 2 | Linux | 25 | 25 | — |
| 3 | Command line | 30 | 28 | — |
| 4 | Python for bioinformatics | 35 | 30 | glue-focused |
| 5 | Sequence databases | 12 | 10 | + GTDB, PubMLST, BV-BRC, NCBI Pathogen Detection |
| 6 | FASTA | 6 | 6 | — |
| 7 | FASTQ | 10 | **14** | + ONT quality model, uBAM, MM/ML tags |
| 8 | SAM/BAM/CRAM | 18 | 18 | long-read CIGAR, supplementary alignments |
| 9 | VCF | 12 | 10 | — |
| 10 | Sequence alignment | 25 | **22** | minimap2-centric; BWT kept as theory |
| 11 | Genome assembly | 30 | **38** | Flye/Autocycler/Trycycler; Medaka; ≥40× rule |
| 12 | Genome annotation | 20 | 18 | Bakta-centric |
| 13 | Variant calling | 22 | **20** | Clair3 + Sniffles2; DeepVariant |
| 14 | Phylogenetics | 25 | 25 | + Gubbins, SKA2, cgMLST |
| 15 | Metagenomics | 30 | **40** | ← PromethION justification lives here |
| 16 | AMR | 20 | 20 | + plasmid/MGE context (long-read advantage) |
| 17 | **Oxford Nanopore** | 45 | **75** | split 17A–17F, see below |
| 18 | Laboratory workflow | 25 | **30** | HMW extraction, BSA, flow-cell management |
| 19 | Pipeline design | 25 | 25 | — |
| 20 | Automation | 30 | 30 | EPI2ME wf-* + nf-core |
| 21 | Reporting | 15 | 15 | — |
| 22 | Quality management | 18 | **22** | ONT-specific controls |
| 23 | ISO 17025 | 25 | **30** | + ISO 23418:2022, instrument qualification |
| 24 | Capstones | 40 | 40 | all four now ONT-only |
| | **Total** | 559 | **605 h ≈ 15 months** | |

### Module 17 expanded (75 h)

| Sub | Title | h | Content |
|---|---|---|---|
| 17A | Nanopore physics & chemistry | 10 | Pore biology, R10.4.1 dual reader head, 5 kHz sampling, motor protein, translocation, why homopolymers used to fail and why they no longer do |
| 17B | Platforms & flow cells | 10 | Flongle / MinION Mk1B–Mk1D / GridION / **PromethION P2 Solo, P2i, P24, P48**; FLO-MIN114 vs FLO-PRO114M; pore-scan interpretation, flow-cell health, washing and reuse (EXP-WSH004) |
| 17C | Library preparation & barcoding | 12 | SQK-LSK114 ligation, SQK-RBK114 rapid, SQK-NBD114.24/.96 native barcoding, BSA effect, fragmentation control, molarity vs mass loading, barcode cross-talk |
| 17D | MinKNOW, Dorado & POD5 | 18 | Run configuration, live basecalling, POD5 vs FAST5, Dorado models fast/hac/sup and version pinning, duplex, modified bases (5mC/5hmC/6mA), demultiplexing, **adaptive sampling / ReadUntil** |
| 17E | Read QC & data management | 10 | NanoPlot/NanoComp, chopper, Filtlong, seqkit; N50 vs yield vs accuracy trade-offs; POD5 retention policy |
| 17F | PromethION operations | 15 | Batch planning, 96-plex design, storage/network architecture, GPU sizing, run failure modes, instrument qualification (IQ/OQ/PQ) for accreditation |

### Capstones (all ONT-only)
1. **Food** — *Listeria monocytogenes* from a RTE plant: closed genome, serogroup, cgMLST, AMR, outbreak linkage. Governed by ISO 23418:2022.
2. **Clinical/AMR** — carbapenem-resistant *Klebsiella pneumoniae*: resolve carbapenemase to plasmid vs chromosome (the long-read-only capability).
3. **Culture-free food** — replicate R5: adaptive sampling for a pathogen in a food matrix, no culture enrichment.
4. **Environmental** — wastewater shotgun metagenomics on PromethION: MAG recovery + AMR gene surveillance.

---

## 5. OPEN QUESTIONS BLOCKING FINAL RECOMMENDATION

1. Expected isolates per batch and batches per month?
2. Will you do shotgun metagenomics on complex matrices, or isolates only?
3. Sample types: food, clinical, environmental, or all three?
4. Is the scope intended for accreditation from day one, or research-use-only first?
5. Existing IT: is there a managed server room, or would compute sit in the lab?
6. Is an Illumina platform already on site (changes the polishing/validation argument)?
