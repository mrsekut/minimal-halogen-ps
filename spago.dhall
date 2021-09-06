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
  , "halogen-store"
  , "newtype"
  , "prelude"
  , "profunctor-lenses"
  , "psci-support"
  , "routing"
  , "routing-duplex"
  , "transformers"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
