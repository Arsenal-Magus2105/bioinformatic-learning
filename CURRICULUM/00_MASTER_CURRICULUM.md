# Applied Bioinformatics for Oxford Nanopore in an ISO 17025 Microbiology Laboratory
## Master Curriculum — Living Document

**Learner:** MSc Biotechnology, strong molecular biology + microbiology + qPCR + ISO 17025, basic Python, zero NGS.
**Goal:** Independent applied bioinformatician able to design, run, interpret and *accredit* Oxford Nanopore workflows.
**Not the goal:** academic research, statistical genetics, human genomics, structural biology.
**Budget:** 8–10 h/week. **Total program:** ~560 h ≈ 14 months.
**Technology baseline:** 2026 (R10.4.1 / Kit 14, Dorado, POD5, ISO 23418:2022).

---

## 0. KNOWLEDGE BASE AUDIT

### Available sources (D:\book\bioinformatic)

| Source | Role in this curriculum | Currency | Trust for |
|---|---|---|---|
| **Buffalo — Bioinformatics Data Skills** (O'Reilly 2015) | **Primary spine** for Modules 2,3,4,6,7,8,19,20 | Concepts current; tool syntax dated (`samtools` pre-1.x idioms, `bwa`) | Unix data tools, Git, project structure, reproducibility philosophy, FASTA/FASTQ/SAM/BED semantics |
| **Ohlebusch — Bioinformatics Algorithms** (2013) | **Theory layer** for Modules 10,11,14 | Timeless (maths) | Suffix arrays, BWT/FM-index, backward search, pairwise/MSA DP, distance-based phylogeny (UPGMA, NJ) |
| **Selzer et al. — Applied Bioinformatics: An Introduction** (1st ed., 2008) | **Historical + database context only** for Modules 1,5 | Largely obsolete | Database taxonomy (INSDC, UniProt, Pfam, InterPro), BLAST concepts, history |

### Gaps I must fill from my own knowledge (nothing in your library covers these)

- **Everything Oxford Nanopore** — flow cells, Kit 14, MinKNOW, Dorado, POD5, duplex, adaptive sampling, modified bases.
- **Long-read assembly & polishing** — Flye, Trycycler/Autocycler, Medaka, Racon.
- **Metagenomics** — Kraken2/Bracken, Emu, GTDB-Tk, binning.
- **AMR genomics** — AMRFinderPlus, ResFinder, CARD/RGI, hAMRonization.
- **Modern typing/outbreak** — cgMLST, chewBBACA, Snippy, IQ-TREE2, Gubbins, SKA2, PopPUNK.
- **Workflow managers** — Nextflow/nf-core, Snakemake, containers.
- **ISO 17025 for NGS** — ISO 23418:2022, CLSI MM09/MM24, EFSA/ECDC WGS guidance, pipeline validation.

### Explicit obsolescence rulings (books vs. 2026 practice)

| Book says | 2026 practice | Why |
|---|---|---|
| Selzer: sequencing = Sanger/shotgun + BAC contigs | Long-read-first (ONT R10.4.1) with optional short-read polish | Cost/read-length inversion; a bacterial genome closes in one flow cell |
| Selzer/Buffalo: BLAST as the universal search | BLAST for *annotation & homology*; minimap2/k-mer methods (Mash, sourmash, skani) for *identity & screening* | BLAST does not scale to Gbp read sets |
| Buffalo: `bwa`/`bowtie2` as the aligner | **minimap2** for long reads (`-x map-ont`, `lr:hq`); bwa-mem2 only for Illumina | Long noisy reads need seed-chain-align, not BWT backtracking |
| Buffalo: `samtools mpileup` + `bcftools call` | **Clair3** (ONT SNV/indel), **Sniffles2** (SV), DeepVariant for r10 | Pileup models assume Illumina error profiles; ONT errors are context/homopolymer-driven |
| Ohlebusch: BWT/FM-index as *the* read-mapping index | Still true for short reads & pangenome graphs; long-read mappers use **minimizer sketches** | Ohlebusch explains *why* the index works — keep it as theory, not as practice |
| Selzer: HMM gene finders (GeneMark/Glimmer) for bacteria | **Bakta** (Prodigal + curated DBs); Prokka is legacy | Annotation is now database-driven and reproducible |
| Any book: Guppy, FAST5, R9.4.1 | **Dorado, POD5, R10.4.1** | Guppy retired; R9 chemistry withdrawn; POD5 is 5–10× faster I/O |

---

## 1. STRATEGIC REFRAME

You are **not** a bioinformatics beginner. You are:
- **Expert** in the wet-lab half of the pipeline (extraction, QC, contamination control, ISO 17025).
- **Novice** in compute (Linux, pipelines, reproducibility).
- **Zero** in sequencing itself.

Therefore the curriculum is deliberately **front-loaded on computing (Modules 2–4)** and **back-loaded on quality systems (22–23)**, where your existing expertise gives you a large head start. The published module numbering is kept as a permanent *index*, but the **teaching order is different** — see §4.

**Three non-obvious decisions baked into this plan:**

1. **You touch Nanopore data in Month 2, not Month 9.** Motivation collapses if you spend 6 months on `awk` before seeing a read. You will analyse public ONT data long before Module 17 formally arrives.
2. **You learn Python *after* the shell, and mostly as glue.** In applied ONT microbiology, 80 % of the work is orchestration + interpretation. Python is for parsing, QC reports, and LIMS integration — not for implementing aligners.
3. **ISO 17025 is taught as a thread, not a finale.** From Module 6 onward, every module ends with "what would an assessor ask?" You already speak this language; use it as the scaffold everything else hangs on.

---

## 2. MODULE MAP

Difficulty: ★ Easy · ★★ Moderate · ★★★ Hard · ★★★★ Expert

| # | Module | Hours | Diff | Hard prerequisites | Signature deliverable |
|---|---|---|---|---|---|
| 0 | Learning Roadmap | 4 | ★ | — | Signed personal study contract + environment built |
| 1 | Modern Molecular Biology for NGS | 12 | ★ | — | Wet-lab → data-artefact map |
| 2 | Linux | 25 | ★★ | 0 | WSL2 + conda + a working bioinformatics box |
| 3 | Command Line & Data Wrangling | 30 | ★★ | 2 | One-liner cookbook (50 recipes) |
| 4 | Python for Bioinformatics | 35 | ★★ | 3 | `fastq_qc.py` CLI tool with tests |
| 5 | Sequence Databases | 12 | ★ | 3 | Scripted NCBI/ENA retrieval + local reference set |
| 6 | FASTA | 6 | ★ | 3 | Reference genome library, checksummed |
| 7 | FASTQ | 10 | ★★ | 4,6 | ONT read QC report (NanoPlot + custom) |
| 8 | SAM / BAM / CRAM | 18 | ★★ | 7 | Alignment QC + coverage report |
| 9 | VCF | 12 | ★★ | 8 | Filtered, annotated variant set |
| 10 | Sequence Alignment | 25 | ★★★ | 6,8 + Ohlebusch ch.2,4,7,8 | minimap2 parameter study |
| 11 | Genome Assembly | 30 | ★★★ | 7,10 | Closed bacterial genome from ONT only |
| 12 | Genome Annotation | 20 | ★★ | 11 | Bakta-annotated GenBank + GFF3 |
| 13 | Variant Calling | 22 | ★★★ | 9,10 | Clair3 ONT variant set, benchmarked |
| 14 | Phylogenetics | 25 | ★★★ | 12,13 + Ohlebusch ch.10 | Outbreak tree with bootstrap + recombination masking |
| 15 | Metagenomics | 30 | ★★★ | 11,12 | Community profile + MAG recovery |
| 16 | Antimicrobial Resistance | 20 | ★★ | 12 | AMR + plasmid report, harmonised |
| 17 | **Oxford Nanopore Technology** | 45 | ★★★ | 7,11 | End-to-end run: POD5 → validated report |
| 18 | Laboratory Workflow | 25 | ★★ | 17 | SOP set: extraction → library → sequencing |
| 19 | Pipeline Design | 25 | ★★★ | 11,12,16 | Versioned, containerised bacterial WGS pipeline |
| 20 | Automation (Nextflow/Snakemake/Git) | 30 | ★★★ | 4,19 | nf-core-style pipeline, CI-tested |
| 21 | Reporting | 15 | ★★ | 16,20 | Auto-generated PDF/HTML lab report |
| 22 | Quality Management for NGS | 18 | ★★ | 19,21 | Validation plan + control strategy |
| 23 | ISO 17025 Implementation | 25 | ★★★ | 22 | Accreditation-ready documentation pack |
| 24 | Capstone Projects | 40 | ★★★★ | all | 4 defensible end-to-end projects |

**Total ≈ 559 h.**

---

## 3. DEPENDENCY GRAPH

```
                         M0 Roadmap
                             |
              +--------------+--------------+
              |                             |
        M1 Molecular Bio               M2 Linux
              |                             |
              |                       M3 Command Line
              |                             |
              |                  +----------+----------+
              |                  |                     |
              |            M4 Python            M5 Databases
              |                  |                     |
              +---------+--------+----------+----------+
                        |                   |
                    M6 FASTA  ----------> M7 FASTQ
                        |                   |
                        |            [ONT data enters here]
                        |                   |
                   M10 Alignment <----------+
                        |
                    M8 SAM/BAM/CRAM
                        |
              +---------+---------+----------------+
              |                   |                |
          M9 VCF            M11 Assembly     M15 Metagenomics
              |                   |                |
       M13 Variant Calling  M12 Annotation         |
              |                   |                |
              |          +--------+--------+       |
              |          |                 |       |
              +----> M14 Phylogenetics   M16 AMR <-+
                            |               |
                            +-------+-------+
                                    |
                          M17 Oxford Nanopore  <-- (introduced early, mastered here)
                                    |
                            M18 Laboratory Workflow
                                    |
                            M19 Pipeline Design
                                    |
                            M20 Automation
                                    |
                            M21 Reporting
                                    |
                            M22 Quality Management
                                    |
                            M23 ISO 17025
                                    |
                            M24 Capstones
```

---

## 4. TEACHING ORDER (differs from module numbering)

| Phase | Months | Modules in teaching order | Milestone |
|---|---|---|---|
| **I — Foundation** | 1–2 | 0 → 2 → 1 → 3 | Working Linux box; you can wrangle text at scale |
| **II — Data Literacy** | 3–4 | 5 → 6 → 7 → **17a (ONT primer)** → 4 | You can QC a real ONT run and explain every field |
| **III — Core Genomics** | 5–7 | 10 → 8 → 11 → 12 | **You close a bacterial genome from ONT reads** ← key checkpoint |
| **IV — Interpretation** | 8–10 | 16 → 9 → 13 → 14 → 15 | You produce an AMR report and an outbreak tree |
| **V — Nanopore Mastery** | 10–11 | **17b (full)** → 18 | You can run and troubleshoot a MinION end-to-end |
| **VI — Engineering** | 11–13 | 19 → 20 → 21 | Your pipeline is versioned, containerised, reproducible |
| **VII — Accreditation** | 13–14 | 22 → 23 | Validation dossier written |
| **VIII — Capstone** | 14+ | 24 | Four defensible projects |

**Checkpoint at end of Phase III (month 7):** if you can go POD5 → closed, annotated genome unaided, you are already employable as a junior applied bioinformatician. Everything after that is what makes you *accreditable*.

---

## 5. REFERENCE PIPELINE (the spine of the whole curriculum)

```
   Isolate / Sample
        |
        v
 [WET LAB]  DNA Extraction (HMW, no vortex, no column shear)
        |                                    <-- M18
        v
   QC: Qubit (mass) + NanoDrop (purity) + TapeStation/Femto (length)
        |
        v
   Library Prep  (SQK-LSK114 ligation | SQK-RBK114 rapid | SQK-NBD114 native barcoding)
        |                                    <-- M17, M18
        v
   Flow Cell Priming + Loading  (R10.4.1 / FLO-MIN114)
        |
        v
 [INSTRUMENT] MinKNOW  --> live basecalling / adaptive sampling
        |
        v
      POD5  (raw signal; FAST5 = legacy)
        |                                    <-- M17
        v
   Dorado basecalling  (fast | hac | sup; simplex/duplex; modified bases)
        |
        v
      FASTQ / uBAM (+ MM/ML tags for methylation)
        |                                    <-- M7
        v
   Read QC + Filtering  (NanoPlot, chopper, Filtlong, seqkit)
        |
        +----------------------------+----------------------------+
        |                            |                            |
        v                            v                            v
  ASSEMBLY ROUTE            MAPPING ROUTE              METAGENOMIC ROUTE
  Flye / Autocycler         minimap2 -x map-ont        Kraken2 + Bracken
        |                         |                    Emu (16S) / metaFlye
        v                         v                            |
  Medaka polish             SAM/BAM/CRAM  <-- M8               v
  (+ Polypolish if Illumina)      |                     Binning (SemiBin2)
        |                         v                            |
        v                   Clair3 / Sniffles2                 v
  QC: CheckM2, BUSCO,             |                     CheckM2 + GTDB-Tk
      QUAST, Bandage              v                            |
        |                       VCF  <-- M9                    |
        v                         |                            |
  ANNOTATION (Bakta)              |                            |
        |                         |                            |
        +------------+------------+----------------------------+
                     |
                     v
        TYPING & INTERPRETATION
        MLST | cgMLST (chewBBACA) | SNP (Snippy) | serotyping
        AMR: AMRFinderPlus + ResFinder + RGI --> hAMRonization   <-- M16
        Plasmids: MOB-suite / Platon
                     |
                     v
        PHYLOGENETICS  (IQ-TREE2, Gubbins, SKA2)   <-- M14
                     |
                     v
        REPORTING (MultiQC + Quarto/Jinja2)         <-- M21
                     |
                     v
        QUALITY RECORD (controls, versions, checksums, audit trail)  <-- M22/M23
                     |
                     v
             ISO 17025 SIGNED REPORT
```

---

## 6. STATUS TRACKER

| Module | Status | Started | Completed | Self-assessment score |
|---|---|---|---|---|
| M0 Learning roadmap | delivered | 2026-07-27 | | |
| **M2 Linux** | **delivered** → `modules/MODULE_02_linux.md` | 2026-07-29 | | /50 |
| T1 Sinh học phân tử & tiến hoá | next | | | |
| M1, M3, và các module còn lại | pending | | | |

---

*Maintained by the mentor session. Each module is delivered as its own file in this folder: `MODULE_NN_<name>.md`.*
