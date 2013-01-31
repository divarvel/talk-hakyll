---
title: Construire des sites statiques avec Hakyll
author: Clément Delafargue, Marc-Antoine Perennou
---

# Les sites statiques

## Pourquoi les sites statiques ?

- légèreté
- flexibilité
- versionnabilité
- sécurité

## La méthode de tout le monde

Générateur + fichier de conf

Rapide, mais trop peu flexible

## La bonne méthode

Bibliothèque / framework pour créer son générateur

Hakyll, Frozen Flask

# Hakyll

## Hakyll

Bibliothèque, EDSL

## Concepts de base

### Item

Couple identifiant / contenu. Par exemple, une page.

    (Identifier, Body)

### Compiler

Compile une ressource **en gérant** les dépendances.

### Context

Permet de passer des données à injecter dans un template.

## Exemples

### Blog

    hakyll-init

C'est bon !

### i18n

Un peu de modifs

### Single page

Là il faut innover
