module MiniHalo.Component.Router where

import MiniHalo.Capability.Navigate (class Navigate, navigate)
import Prelude
import MiniHalo.Data.Route (Route(..), route)
import Routing.Duplex as RD
import Routing.Hash (getHash)

import Data.Either (hush)
import Data.Maybe (Maybe(..), fromMaybe)
import Effect.Class (class MonadEffect, liftEffect)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import MiniHalo.Page.Home as Home
-- import Page.Register as Register
import Web.Event.Event (preventDefault)
import Web.UIEvent.MouseEvent (toEvent, MouseEvent)

type State =
  { route :: Maybe Route
  }

data Query a = Navigate Route a

data Action
  = Initialize
  | GoTo Route MouseEvent

type ChildSlots =
  ( home :: Home.Slot Unit
  -- , feed :: Register.Slot Unit
  -- , profile :: Register.Slot Unit
  )

component
  :: ∀ i o m
  . MonadEffect m
  => Navigate m
  => H.Component Query i o m
component =
  H.mkComponent
  { initialState: const { route: Nothing }
  , render
  , eval: H.mkEval $ H.defaultEval
    { handleAction = handleAction
    , handleQuery = handleQuery
    , initialize = Just Initialize
    }
  }

render :: ∀ m. State -> H.ComponentHTML Action ChildSlots m
render st = navbar $ case st.route of
  Nothing -> HH.h1_ [ HH.text "Oh no! That page wasn't found" ]
  Just route -> case route of
    Home -> HH.slot Home._home unit Home.component unit absurd
    -- Register -> HH.slot Register._register unit Register.component unit absurd


handleAction
  :: ∀ o m
  . MonadEffect m
  => Navigate m
  => Action
  -> H.HalogenM State Action ChildSlots o m Unit
handleAction = case _ of
  Initialize -> do
    initialRoute <- hush <<< (RD.parse route) <$> H.liftEffect getHash
    navigate $ fromMaybe Home initialRoute
  GoTo route e -> do
    liftEffect $ preventDefault $ toEvent e
    mRoute <- H.gets _.route
    when ( mRoute /= Just route ) $ navigate route


handleQuery :: ∀ a o m. Query a -> H.HalogenM State Action ChildSlots o m ( Maybe a )
handleQuery = case _ of
  Navigate route a -> do
    mRoute <- H.gets _.route
    when ( mRoute /= Just route ) $
      H.modify_ _ { route = Just route }
    pure ( Just a )



navbar :: ∀ a . HH.HTML a Action -> HH.HTML a Action
navbar html =
  HH.div_
  [ HH.ul_
    [ HH.li_
      -- [ HH.a
      --   [ HP.href "#"
      --   , HE.onClick ( GoTo RSSList )
      --   ]
      --   [ HH.text "RSSList" ]
      -- ]
    -- , HH.li_
      [ HH.a
        [ HP.href "#"
        , HE.onClick (  GoTo Home )
        ]
        [ HH.text "home" ]
      ]
    ]
  ,  html
  ]