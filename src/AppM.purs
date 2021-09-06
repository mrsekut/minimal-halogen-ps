module MiniHalo.AppM where

import Prelude
import Effect.Class (class MonadEffect)
import Effect.Aff ( Aff )
import Effect.Aff.Class ( class MonadAff )
import MiniHalo.Store as Store
import Halogen as H
import Halogen.Store.Monad (StoreT, runStoreT)
import Safe.Coerce (coerce)



newtype AppM a = AppM (StoreT Store.Action Store.Store Aff a)

derive newtype instance Functor AppM
derive newtype instance Apply AppM
derive newtype instance Applicative AppM
derive newtype instance Bind AppM
derive newtype instance Monad AppM
derive newtype instance MonadEffect AppM
derive newtype instance MonadAff AppM


runAppM :: ∀ q i o. Store.Store -> H.Component q i o AppM -> Aff (H.Component q i o Aff)
runAppM store = runStoreT store Store.reduce <<< coerce

