{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "my-project"
, dependencies =
  [ "aff"
  , "console"
  , "const"
  , "effect"
  , "halogen"
  , "prelude"
  , "profunctor-lenses"
  , "psci-support"
  , "routing-duplex"
  , "transformers"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
