# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Boltz2 test repository focused on protein-ligand affinity calculations. The project appears to be in early stages with minimal structure.

## Key Files

- `samples/affinity.yaml`: Contains sample configuration for protein-ligand affinity calculations
  - Defines protein sequences (FASTA format)
  - Defines ligands using SMILES notation
  - Specifies affinity properties between molecules

## Development Setup

As this project has no established build system or dependencies yet, consider:

1. **For Python-based Boltz2 work**:
   - Create a `requirements.txt` or `pyproject.toml` with Boltz2 dependencies
   - Set up virtual environment: `python -m venv venv && source venv/bin/activate`
   
2. **For running Boltz2**:
   - Check official Boltz2 documentation for installation and usage
   - Typical command pattern: `boltz predict --input samples/affinity.yaml`

## Architecture Notes

The project structure suggests a molecular modeling workflow:
- Input: YAML files defining molecular structures and relationships
- Processing: Boltz2 predictions for protein-ligand interactions
- Expected output: Affinity predictions, structural models, or binding scores

## Sample Data Format

The `affinity.yaml` follows this structure:
- `version`: Configuration version
- `sequences`: List of molecules (proteins and ligands)
  - Proteins: ID and amino acid sequence
  - Ligands: ID and SMILES notation
- `properties`: Molecular relationships (e.g., affinity bindings)