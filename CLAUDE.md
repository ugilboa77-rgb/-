# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Running the Game

Open `index.html` directly in a browser. There is no build step, no package manager, and no server required.

## Project Overview

Single-file HTML5 Space Invaders clone ("פולשי החלל" - Hebrew for "Space Invaders"). The entire game lives in `index.html` (~920 lines of inline JavaScript + CSS).

## Architecture

All game code is monolithic JavaScript inside `index.html`. Key sections:

**Constants** (lines ~155-162): Canvas size (800×600), alien grid (10×5), sprite sizes, scoring.

**Audio system** (lines ~169-241): Procedurally synthesized sounds via Web Audio API — no audio files. Six sound types: shoot, alienDie, playerHit, ufoHit, gameOver, waveUp.

**Image upload system** (lines ~243-280): Players upload custom ship/alien images (PNG/JPG/GIF). Fallback to inline pixel-art drawing if no image is provided.

**Game state** (lines ~294-350): Single `game` object holds player, alien grid (2D array), bullets, UFO, shields, stars, particles, and flags.

**Game loop** (lines ~899-922): `requestAnimationFrame` at 60 FPS, calls `update()` then `draw()`.

**Collision detection** (lines ~515-586): AABB overlap checks between player bullets↔aliens, player bullets↔UFO, all bullets↔shields, alien bullets↔player.

**Rendering** (lines ~650-887): Canvas 2D API. Custom uploaded images drawn with `drawImage`; fallback draws pixel art procedurally.

## Key Game Parameters (all hardcoded)

- Alien base speed: 0.6 px/frame, scales with wave number and remaining alien count
- Alien shoot interval: 90 frames (decreases each wave)
- UFO spawn: every 600–1000 frames, random direction
- Player shoot cooldown: 18 frames
- Player invincibility after hit: 120 frames
- Shields reset every 2 waves; 4 shield bunkers with HP-based destruction

## Persistence

Hi-score stored in `localStorage` under the key used in the JS (search for `localStorage` in the file).
