open import prelude
open import typ

-- instrinsically typed marked expressions
module mexp where
  infix  4 _⊢⇒_
  infix  4 _⊢⇐_
  infix  4 _∋_
  infixl 5 _,_

  -- variables
  FreeVar : Set
  FreeVar = ℕ

  data Ctx : Set where
    ∅   : Ctx
    _,_ : Ctx → Typ → Ctx

  data _∋_ : (Γ : Ctx) (τ : Typ) → Set where
    Z  : ∀ {Γ τ}            → Γ , τ  ∋ τ
    S  : ∀ {Γ τ τ′} → Γ ∋ τ → Γ , τ′ ∋ τ

  mutual
    -- synthesis
    data _⊢⇒_ : (Γ : Ctx) (τ : Typ) → Set where
      -- MSHole
      ⊢⦇-⦈^_ : ∀ {Γ}
        → ℕ
        → Γ ⊢⇒ unknown

      -- MSVar
      ⊢_ : ∀ {Γ τ}
        → Γ ∋ τ
        → Γ ⊢⇒ τ

      -- MSLam
      ⊢λ∶_∙_ : ∀ {Γ τ₂}
        → (τ₁ : Typ)
        → Γ , τ₁ ⊢⇒ τ₂
        → Γ ⊢⇒ τ₁ -→ τ₂

      -- MSAp1
      ⊢_∙_[_] : ∀ {Γ τ τ₁ τ₂}
        → Γ ⊢⇒ τ
        → Γ ⊢⇐ τ₁
        → τ ▸ τ₁ -→ τ₂
        → Γ ⊢⇒ τ₂

      -- MSAp2
      ⊢⸨_⸩∙_[_] : ∀ {Γ τ}
        → Γ ⊢⇒ τ
        → Γ ⊢⇐ unknown
        → τ !▸
        → Γ ⊢⇒ unknown

      -- MSNum
      ⊢ℕ_ : ∀ {Γ}
        → ℕ
        → Γ ⊢⇒ num

      -- MSPlus
      ⊢_+_ : ∀ {Γ}
        → Γ ⊢⇐ num
        → Γ ⊢⇐ num
        → Γ ⊢⇒ num

      -- MSTrue
      ⊢tt : ∀ {Γ}
        → Γ ⊢⇒ bool

      -- MSFalse
      ⊢ff : ∀ {Γ}
        → Γ ⊢⇒ bool

      -- MSIf
      ⊢_∙_∙_[_]  : ∀ {Γ τ₁ τ₂ τ}
        → Γ ⊢⇐ bool
        → Γ ⊢⇒ τ₁
        → Γ ⊢⇒ τ₂
        → τ₁ ⊔ τ₂ ⇒ τ
        → Γ ⊢⇒ τ

      -- MSUnbound
      ⊢⟦_⟧ : ∀ {Γ}
        → FreeVar
        → Γ ⊢⇒ unknown

      -- MSInconsistentBranches
      ⊢⦉_∙_∙_⦊[_] : ∀ {Γ τ₁ τ₂}
        → Γ ⊢⇐ bool
        → Γ ⊢⇒ τ₁
        → Γ ⊢⇒ τ₂
        → τ₁ ~̸ τ₂
        → Γ ⊢⇒ unknown

    -- analysis
    data _⊢⇐_ : (Γ : Ctx) (τ : Typ) → Set where
      -- MALam
      ⊢λ∶_∙_[_∙_] : ∀ {Γ τ₁ τ₂ τ₃}
        → (τ : Typ)
        → Γ , τ ⊢⇐ τ₂
        → τ₃ ▸ τ₁ -→ τ₂
        → τ ~ τ₁
        → Γ ⊢⇐ τ₃

      -- MAIf
      ⊢_∙_∙_ : ∀ {Γ τ}
        → Γ ⊢⇐ bool
        → Γ ⊢⇐ τ
        → Γ ⊢⇐ τ
        → Γ ⊢⇐ τ

      -- MAInconsistentTypes
      ⊢⸨_⸩[_] : ∀ {Γ τ τ′}
        → Γ ⊢⇒ τ′
        → τ ~̸ τ′
        → Γ ⊢⇐ τ

      -- MASubsume
      ⊢∙_[_] : ∀ {Γ τ τ′}
        → Γ ⊢⇒ τ′
        → τ ~ τ′
        → Γ ⊢⇐ τ