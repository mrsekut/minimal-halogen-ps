module Main where

import Prelude

import Data.Const (Const)
import Effect (Effect)
import Effect.Aff (Aff)
import Halogen as H
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.HTML as HH
import Halogen.VDom.Driver (runUI)


-- | Main

main :: Effect Unit
main = runHalogenAff do
  body <- awaitBody
  runUI (staticComponent staticHtml) unit body



-- | Component

type StaticHTML = H.ComponentHTML Unit () Aff
staticComponent :: StaticHTML
                -> H.Component HH.HTML (Const Void) Unit Void Aff
staticComponent renderHtml =
  H.mkComponent
    { initialState: const unit
    , render: \_ -> renderHtml
    , eval: H.mkEval H.defaultEval
    }



-- | Html

staticHtml :: StaticHTML
staticHtml =
  HH.div_
    [ HH.div_
      [ HH.span_
        [ HH.text "This is text in a span!" ]
      ]
    , HH.button_
      [ HH.text "You can click me, but I don't do anything." ]
    ]