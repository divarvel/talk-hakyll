% Construire des sites statiques avec Hakyll
% Clément Delafargue, Marc-Antoine Perennou
% 02 février 2013

# Les sites statiques

## Pourquoi les sites statiques ?

Avantages :

 - légèreté
 - sécurité
 - workflow (vim, git, déploiement)

Inconvénients :

 - pas de composante dynamique (déporté sur JS + API REST)
 - rigidité dans la structure (pas toujours)

## La méthode de tout le monde

Générateur (exécutable) + fichier de conf

Rapide, mais trop peu flexible

## La bonne méthode

Bibliothèque / framework pour créer son générateur

Hakyll (haskell), Frozen Flask (python)

## La bonne méthode

Décrire pipeline [ source -> destination ]

Inverse d'un framework web standard

# Hakyll

## Hakyll

Bibliothèque, fournit un EDSL pour construire un générateur.

    EDSL: Embedded Domain Specific Language

Permet de décrire comment construire le site à partir des fichiers texte

Utilise Pandoc. Gère un gazillion de formats (entrée et sortie).
Utilisable avec tout ce qu'on veut (pandoc est un compilateur parmi d'autres)

## Exemple - un blog

```haskell

main = hakyl $ do
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "templates/*" $do
        compile templateCompiler

    match "posts/*" $ do
        route   $ setExtension ".html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html" defaultContext
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    create ["index.html"] $ do
        route idRoute
        compile $ do
            posts <- take 3 $ recentFirst <$> loadAll "posts/*"
            itemTpl <- loadBody "templates/postitem.html"
            list <- applyTemplateList itmTpl defaultContext posts
            makeItem list
                >>= loadAndApplyTemplate "templates/index.html" defaultContext
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls
```

## Exemple - un blog

 - On compresse les CSS
 - On génère les templates
 - On génère les posts
 - On génère l'index

## Exemple - un blog

 - On compresse les CSS
 - On génère les templates

```haskell

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "templates/*" $do
        compile templateCompiler
```

## Exemple - un blog

- On génère les pages des posts
    - md -> html
    - application des templates
    - relativizeUrls

```haskell
    match "posts/*" $ do
        route   $ setExtension ".html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html" defaultContext
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls
```

## Exemple - un blog

- On crée l'index
    - On déclare la création de page
    - On récupère les 3 derniers posts
    - On leur applique le template à chaque post
    - application des templates
    - relativizeUrls

```haskell
    create ["index.html"] $ do
        route idRoute
        compile $ do
            posts <- take 3 $ recentFirst <$> loadAll "posts/*"
            itemTpl <- loadBody "templates/postitem.html"
            list <- applyTemplateList itmTpl defaultContext posts
            makeItem list
                >>= loadAndApplyTemplate "templates/index.html" defaultContext
                >>= loadAndApplyTemplate "templates/default.html" defaultContext
                >>= relativizeUrls
```

## Concepts de base

Hakyll est basé sur quelques types de base que l'on assemble pour avoir ce que
l'on veut.

------------------------------

### Compiler

Compile une ressource **en gérant** les dépendances.

------------------------------

### Context

Permet de passer des données à injecter dans un template.

Par exemple, defaultContext injecte :

 - métadonnées (title, author, …)
 - body

Dans le template :

```html
    <article>
        <h1>$title$</h1>
        $body
    </article>
```

------------------------------

### Context

Possibilité de construire ses propres contextes

 - données statiques
 - fonctions  (`$func arg$`)
 - date
 - …

```haskell
    myContext `mappend` defaultContext
```

## Exemples

------------------------------

### Blog

Cf plus haut.

    hakyll-init

C'est bon !

------------------------------

### i18n

Un peu de modifs dans la structure

```haskell
    match "en/posts/*.md" $ do
        …
```

------------------------------

### Single page

Là il faut innover :

Construction des contextes à la main.
