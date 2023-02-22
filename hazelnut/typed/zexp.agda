open import prelude
open import core

open import hazelnut.typed.ztyp

-- cursor expressions
module hazelnut.typed.zexp where
  -- zippered expressions
  mutual
    data -_⊢⇒_ : (Γ : MCtx) → (τ : Typ) → Set where
      ⊢▹_◃ : ∀ {Γ : MCtx} {τ}
        → (ě : Γ ⊢⇒ τ)
        → - Γ ⊢⇒ τ

      ⊢λ₁∶_∙_[_] : ∀ {Γ τ}
        → (τ^ : ZTyp)
        → (ě : Γ , (τ^ ◇τ) ⊢⇒ τ)
        → (x : Var)
        → - Γ ⊢⇒ ((τ^ ◇τ) -→ τ)

      ⊢λ₂∶_∙_[_] : ∀ {Γ τ′}
        → (τ : Typ)
        → (ê : - Γ , τ ⊢⇒ τ′)
        → (x : Var)
        → - Γ ⊢⇒ (τ -→ τ′)

      ⊢_∙₁_[_] : ∀ {Γ τ τ₁ τ₂}
        → (ê₁ : - Γ ⊢⇒ τ)
        → (ě₂ : Γ ⊢⇐ τ₁)
        → (τ▸ : τ ▸ τ₁ -→ τ₂)
        → - Γ ⊢⇒ τ₂

      ⊢_∙₂_[_] : ∀ {Γ τ τ₁ τ₂}
        → (ě₁ : Γ ⊢⇒ τ)
        → (ê₂ : - Γ ⊢⇐ τ₁)
        → (τ▸ : τ ▸ τ₁ -→ τ₂)
        → - Γ ⊢⇒ τ₂

      ⊢⸨_⸩∙₁_[_] : ∀ {Γ τ}
        → (ê₁ : - Γ ⊢⇒ τ)
        → (ě₂ : Γ ⊢⇐ unknown)
        → (τ!▸ : τ !▸)
        → - Γ ⊢⇒ unknown

      ⊢⸨_⸩∙₂_[_] : ∀ {Γ τ}
        → (ě₁ : Γ ⊢⇒ τ)
        → (ê₂ : - Γ ⊢⇐ unknown)
        → (τ!▸ : τ !▸)
        → - Γ ⊢⇒ unknown

      ⊢←₁_∙_[_] : ∀ {Γ τ₁ τ₂}
        → (ê₁ : - Γ ⊢⇒ τ₁)
        → (ě₂ : Γ , τ₁ ⊢⇒ τ₂)
        → (x : Var)
        → - Γ ⊢⇒ τ₂

      ⊢←₂_∙_[_] : ∀ {Γ τ₁ τ₂}
        → (ě₁ : Γ ⊢⇒ τ₁)
        → (ê₂ : - Γ , τ₁ ⊢⇒ τ₂)
        → (x : Var)
        → - Γ ⊢⇒ τ₂

      ⊢_+₁_ : ∀ {Γ}
        → (ê₁ : - Γ ⊢⇐ num)
        → (ě₂ : Γ ⊢⇐ num)
        → - Γ ⊢⇒ num

      ⊢_+₂_ : ∀ {Γ}
        → (ě₁ : Γ ⊢⇐ num)
        → (ê₂ : - Γ ⊢⇐ num)
        → - Γ ⊢⇒ num

      ⊢_∙₁_∙_[_] : ∀ {Γ τ₁ τ₂ τ}
        → (ê₁ : - Γ ⊢⇐ bool)
        → (ě₂ : Γ ⊢⇒ τ₁)
        → (ě₃ : Γ ⊢⇒ τ₂)
        → (τ₁⊔τ₂ : τ₁ ⊔ τ₂ ⇒ τ)
        → - Γ ⊢⇒ τ

      ⊢_∙₂_∙_[_] : ∀ {Γ τ₁ τ₂ τ}
        → (ě₁ : Γ ⊢⇐ bool)
        → (ê₂ : - Γ ⊢⇒ τ₁)
        → (ě₃ : Γ ⊢⇒ τ₂)
        → (τ₁⊔τ₂ : τ₁ ⊔ τ₂ ⇒ τ)
        → - Γ ⊢⇒ τ

      ⊢_∙₃_∙_[_] : ∀ {Γ τ₁ τ₂ τ}
        → (ě₁ : Γ ⊢⇐ bool)
        → (ě₂ : Γ ⊢⇒ τ₁)
        → (ê₃ : - Γ ⊢⇒ τ₂)
        → (τ₁⊔τ₂ : τ₁ ⊔ τ₂ ⇒ τ)
        → - Γ ⊢⇒ τ

      ⊢⦉_∙₁_∙_⦊[_] : ∀ {Γ τ₁ τ₂}
        → (ê₁ : - Γ ⊢⇐ bool)
        → (ě₂ : Γ ⊢⇒ τ₁)
        → (ě₃ : Γ ⊢⇒ τ₂)
        → (τ₁~̸τ₂ : τ₁ ~̸ τ₂)
        → - Γ ⊢⇒ unknown

      ⊢⦉_∙₂_∙_⦊[_] : ∀ {Γ τ₁ τ₂}
        → (ě₁ : Γ ⊢⇐ bool)
        → (ê₂ : - Γ ⊢⇒ τ₁)
        → (ě₃ : Γ ⊢⇒ τ₂)
        → (τ₁~̸τ₂ : τ₁ ~̸ τ₂)
        → - Γ ⊢⇒ unknown

      ⊢⦉_∙₃_∙_⦊[_] : ∀ {Γ τ₁ τ₂}
        → (ě₁ : Γ ⊢⇐ bool)
        → (ě₂ : Γ ⊢⇒ τ₁)
        → (ê₃ : - Γ ⊢⇒ τ₂)
        → (τ₁~̸τ₂ : τ₁ ~̸ τ₂)
        → - Γ ⊢⇒ unknown

    data ZSubsumable : {Γ : MCtx} {τ : Typ} → (ê : - Γ ⊢⇒ τ) → Set where
      ZSuCursor : ∀ {Γ τ}
        → {ě : Γ ⊢⇒ τ}
        → (su : MSubsumable ě)
        → ZSubsumable {Γ} (⊢▹ ě ◃)

      ZSuZipApL1 : ∀ {Γ τ τ₁ τ₂}
        → {ê₁ : - Γ ⊢⇒ τ}
        → {ě₂ : Γ ⊢⇐ τ₁}
        → {τ▸ : τ ▸ τ₁ -→ τ₂}
        → ZSubsumable {Γ} (⊢ ê₁ ∙₁ ě₂ [ τ▸ ])

      ZSuZipApR1 : ∀ {Γ τ τ₁ τ₂}
        → {ě₁ : Γ ⊢⇒ τ}
        → {ê₂ : - Γ ⊢⇐ τ₁}
        → {τ▸ : τ ▸ τ₁ -→ τ₂}
        → ZSubsumable {Γ} (⊢ ě₁ ∙₂ ê₂ [ τ▸ ])

      ZSuZipApL2 : ∀ {Γ τ}
        → {ê₁ : - Γ ⊢⇒ τ}
        → {ě₂ : Γ ⊢⇐ unknown}
        → {τ!▸ : τ !▸}
        → ZSubsumable {Γ} (⊢⸨ ê₁ ⸩∙₁ ě₂ [ τ!▸ ])

      ZSuZipApR2 : ∀ {Γ τ}
        → {ě₁ : Γ ⊢⇒ τ}
        → {ê₂ : - Γ ⊢⇐ unknown}
        → {τ!▸ : τ !▸}
        → ZSubsumable {Γ} (⊢⸨ ě₁ ⸩∙₂ ê₂ [ τ!▸ ])

      ZSuPlus1 : ∀ {Γ}
        → {ê₁ : - Γ ⊢⇐ num}
        → {ě₂ : Γ ⊢⇐ num}
        → ZSubsumable {Γ} (⊢ ê₁ +₁ ě₂)

      ZSuPlus2 : ∀ {Γ}
        → {ě₁ : Γ ⊢⇐ num}
        → {ê₂ : - Γ ⊢⇐ num}
        → ZSubsumable {Γ} (⊢ ě₁ +₂ ê₂)

      ZSuInconsistentBranchesC : ∀ {Γ τ₁ τ₂}
        → {ê₁ : - Γ ⊢⇐ bool}
        → {ě₂ : Γ ⊢⇒ τ₁}
        → {ě₃ : Γ ⊢⇒ τ₂}
        → {τ₁~̸τ₂ : τ₁ ~̸ τ₂}
        → ZSubsumable {Γ} (⊢⦉ ê₁ ∙₁ ě₂ ∙ ě₃ ⦊[ τ₁~̸τ₂ ])

      ZSuInconsistentBranchesL : ∀ {Γ τ₁ τ₂}
        → {ě₁ : Γ ⊢⇐ bool}
        → {ê₂ : - Γ ⊢⇒ τ₁}
        → {ě₃ : Γ ⊢⇒ τ₂}
        → {τ₁~̸τ₂ : τ₁ ~̸ τ₂}
        → ZSubsumable {Γ} (⊢⦉ ě₁ ∙₂ ê₂ ∙ ě₃ ⦊[ τ₁~̸τ₂ ])

      ZSuInconsistentBranchesR : ∀ {Γ τ₁ τ₂}
        → {ě₁ : Γ ⊢⇐ bool}
        → {ě₂ : Γ ⊢⇒ τ₁}
        → {ê₃ : - Γ ⊢⇒ τ₂}
        → {τ₁~̸τ₂ : τ₁ ~̸ τ₂}
        → ZSubsumable {Γ} (⊢⦉ ě₁ ∙₃ ě₂ ∙ ê₃ ⦊[ τ₁~̸τ₂ ])

    data -_⊢⇐_ : (Γ : MCtx) → (τ : Typ) → Set where
      ⊢▹_◃ : ∀ {Γ : MCtx} {τ}
        → (ě : Γ ⊢⇐ τ)
        → - Γ ⊢⇐ τ

      ⊢λ₁∶_∙_[_∙_∙_] : ∀ {Γ τ₁ τ₂ τ₃}
        → (τ^ : ZTyp)
        → (ě : Γ , (τ^ ◇τ) ⊢⇐ τ₂)
        → (τ₃▸ : τ₃ ▸ τ₁ -→ τ₂)
        → (τ~τ₁ : (τ^ ◇τ) ~ τ₁)
        → (x : Var)
        → - Γ ⊢⇐ τ₃

      ⊢λ₂∶_∙_[_∙_∙_] : ∀ {Γ τ₁ τ₂ τ₃}
        → (τ : Typ)
        → (ê : - Γ , τ ⊢⇐ τ₂)
        → (τ₃▸ : τ₃ ▸ τ₁ -→ τ₂)
        → (τ~τ₁ : τ ~ τ₁)
        → (x : Var)
        → - Γ ⊢⇐ τ₃

      ⊢⸨λ₁∶_∙_⸩[_∙_] : ∀ {Γ τ′}
        → (τ^ : ZTyp)
        → (ě : Γ , (τ^ ◇τ) ⊢⇐ unknown)
        → (τ′!▸ : τ′ !▸)
        → (x : Var)
        → - Γ ⊢⇐ τ′

      ⊢⸨λ₂∶_∙_⸩[_∙_] : ∀ {Γ τ′}
        → (τ : Typ)
        → (ê : - Γ , τ ⊢⇐ unknown)
        → (τ′!▸ : τ′ !▸)
        → (x : Var)
        → - Γ ⊢⇐ τ′

      ⊢λ₁∶⸨_⸩∙_[_∙_∙_] : ∀ {Γ τ₁ τ₂ τ₃}
        → (τ^ : ZTyp)
        → (ě : Γ , (τ^ ◇τ) ⊢⇐ τ₂)
        → (τ₃▸ : τ₃ ▸ τ₁ -→ τ₂)
        → (τ~̸τ₁ : (τ^ ◇τ) ~̸ τ₁)
        → (x : Var)
        → - Γ ⊢⇐ τ₃

      ⊢λ₂∶⸨_⸩∙_[_∙_∙_] : ∀ {Γ τ₁ τ₂ τ₃}
        → (τ : Typ)
        → (ê : - Γ , τ ⊢⇐ τ₂)
        → (τ₃▸ : τ₃ ▸ τ₁ -→ τ₂)
        → (τ~̸τ₁ : τ ~̸ τ₁)
        → (x : Var)
        → - Γ ⊢⇐ τ₃

      ⊢←₁_∙_[_] : ∀ {Γ τ₁ τ₂}
        → (ê₁ : - Γ ⊢⇒ τ₁)
        → (ě₂ : Γ , τ₁ ⊢⇐ τ₂)
        → (x : Var)
        → - Γ ⊢⇐ τ₂

      ⊢←₂_∙_[_] : ∀ {Γ τ₁ τ₂}
        → (ě₁ : Γ ⊢⇒ τ₁)
        → (ê₂ : - Γ , τ₁ ⊢⇐ τ₂)
        → (x : Var)
        → - Γ ⊢⇐ τ₂

      ⊢_∙₁_∙_ : ∀ {Γ τ}
        → (ê₁ : - Γ ⊢⇐ bool)
        → (ě₂ : Γ ⊢⇐ τ)
        → (ě₃ : Γ ⊢⇐ τ)
        → - Γ ⊢⇐ τ

      ⊢_∙₂_∙_ : ∀ {Γ τ}
        → (ě₁ : Γ ⊢⇐ bool)
        → (ê₂ : - Γ ⊢⇐ τ)
        → (ě₃ : Γ ⊢⇐ τ)
        → - Γ ⊢⇐ τ

      ⊢_∙₃_∙_ : ∀ {Γ τ}
        → (ě₁ : Γ ⊢⇐ bool)
        → (ě₂ : Γ ⊢⇐ τ)
        → (ê₃ : - Γ ⊢⇐ τ)
        → - Γ ⊢⇐ τ

      ⊢⸨_⸩[_∙_] : ∀ {Γ τ τ′}
        → (ê : - Γ ⊢⇒ τ′)
        → (τ~̸τ′ : τ ~̸ τ′)
        → (su : ZSubsumable ê)
        → - Γ ⊢⇐ τ

      ⊢∙_[_∙_] : ∀ {Γ τ τ′}
        → (ê : - Γ ⊢⇒ τ′)
        → (τ~τ′ : τ ~ τ′)
        → (su : ZSubsumable ê)
        → - Γ ⊢⇐ τ

  -- functional cursor erasure
  mutual
    _◇⇒ : ∀ {Γ τ} → (ê : - Γ ⊢⇒ τ) → Γ ⊢⇒ τ
    ⊢▹ ě ◃ ◇⇒ = ě
    (⊢λ₁∶ τ^ ∙ ě [ x ])           ◇⇒ = ⊢λ∶ (τ^ ◇τ) ∙ ě [ x ]
    (⊢λ₂∶ τ ∙ ê [ x ])            ◇⇒ = ⊢λ∶ τ ∙ (ê ◇⇒) [ x ]
    (⊢ ê ∙₁ ě [ τ▸ ])             ◇⇒ = ⊢ (ê ◇⇒) ∙ ě [ τ▸ ]
    (⊢ ě ∙₂ ê [ τ▸ ])             ◇⇒ = ⊢ ě ∙ (ê ◇⇐) [ τ▸ ]
    (⊢⸨ ê ⸩∙₁ ě [ τ!▸ ])          ◇⇒ = ⊢⸨ (ê ◇⇒) ⸩∙ ě [ τ!▸ ]
    (⊢⸨ ě ⸩∙₂ ê [ τ!▸ ])          ◇⇒ = ⊢⸨ ě ⸩∙ (ê ◇⇐) [ τ!▸ ]
    (⊢←₁ ê ∙ ě [ x ])             ◇⇒ = ⊢← (ê ◇⇒) ∙ ě [ x ]
    (⊢←₂ ě ∙ ê [ x ])             ◇⇒ = ⊢← ě ∙ (ê ◇⇒) [ x ]
    (⊢ ê +₁ ě)                    ◇⇒ = ⊢ (ê ◇⇐) + ě
    (⊢ ě +₂ ê)                    ◇⇒ = ⊢ ě + (ê ◇⇐)
    (⊢ ê ∙₁ ě₂ ∙ ě₃ [ τ₁⊔τ₂ ])    ◇⇒ = ⊢ (ê ◇⇐) ∙ ě₂ ∙ ě₃ [ τ₁⊔τ₂ ]
    (⊢ ě₁ ∙₂ ê ∙ ě₃ [ τ₁⊔τ₂ ])    ◇⇒ = ⊢ ě₁ ∙ (ê ◇⇒) ∙ ě₃ [ τ₁⊔τ₂ ]
    (⊢ ě₁ ∙₃ ě₂ ∙ ê₃ [ τ₁⊔τ₂ ])   ◇⇒ = ⊢ ě₁ ∙ ě₂ ∙ (ê₃ ◇⇒) [ τ₁⊔τ₂ ]
    (⊢⦉ ê₁ ∙₁ ě₂ ∙ ě₃ ⦊[ τ₁~̸τ₂ ]) ◇⇒ = ⊢⦉ (ê₁ ◇⇐) ∙ ě₂ ∙ ě₃ ⦊[ τ₁~̸τ₂ ]
    (⊢⦉ ě₁ ∙₂ ê₂ ∙ ě₃ ⦊[ τ₁~̸τ₂ ]) ◇⇒ = ⊢⦉ ě₁ ∙ (ê₂ ◇⇒) ∙ ě₃ ⦊[ τ₁~̸τ₂ ]
    (⊢⦉ ě₁ ∙₃ ě₂ ∙ ê₃ ⦊[ τ₁~̸τ₂ ]) ◇⇒ = ⊢⦉ ě₁ ∙ ě₂ ∙ (ê₃ ◇⇒) ⦊[ τ₁~̸τ₂ ]

    ZSu→MSu : ∀ {Γ τ} {ê : - Γ ⊢⇒ τ} → (zsu : ZSubsumable ê) → MSubsumable (ê ◇⇒)
    ZSu→MSu (ZSuCursor su) = su
    ZSu→MSu ZSuZipApL1 = MSuAp1
    ZSu→MSu ZSuZipApR1 = MSuAp1
    ZSu→MSu ZSuZipApL2 = MSuAp2
    ZSu→MSu ZSuZipApR2 = MSuAp2
    ZSu→MSu ZSuPlus1 = MSuPlus
    ZSu→MSu ZSuPlus2 = MSuPlus
    ZSu→MSu ZSuInconsistentBranchesC = MSuInconsistentBranches
    ZSu→MSu ZSuInconsistentBranchesL = MSuInconsistentBranches
    ZSu→MSu ZSuInconsistentBranchesR = MSuInconsistentBranches

    _◇⇐ : ∀ {Γ τ} → (ê : - Γ ⊢⇐ τ) → Γ ⊢⇐ τ
    ⊢▹ ě ◃ ◇⇐ = ě
    ⊢λ₁∶ τ^ ∙ ě [ τ₃▸ ∙ τ~τ₁ ∙ x ] ◇⇐ = ⊢λ∶ (τ^ ◇τ) ∙ ě [ τ₃▸ ∙ τ~τ₁ ∙ x ]
    ⊢λ₂∶ τ ∙ ê [ τ₃▸ ∙ τ~τ₁ ∙ x ] ◇⇐ = ⊢λ∶ τ ∙ (ê ◇⇐) [ τ₃▸ ∙ τ~τ₁ ∙ x ]
    ⊢⸨λ₁∶ τ^ ∙ ě ⸩[ τ′!▸ ∙ x ] ◇⇐ = ⊢⸨λ∶ (τ^ ◇τ) ∙ ě ⸩[ τ′!▸ ∙ x ]
    ⊢⸨λ₂∶ τ ∙ ê ⸩[ τ′!▸ ∙ x ] ◇⇐ = ⊢⸨λ∶ τ ∙ (ê ◇⇐) ⸩[ τ′!▸ ∙ x ]
    ⊢λ₁∶⸨ τ^ ⸩∙ ě [ τ₃▸ ∙ τ~̸τ₁ ∙ x ] ◇⇐ = ⊢λ∶⸨ τ^ ◇τ ⸩∙ ě [ τ₃▸ ∙ τ~̸τ₁ ∙ x ]
    ⊢λ₂∶⸨ τ ⸩∙ ê [ τ₃▸ ∙ τ~̸τ₁ ∙ x ] ◇⇐ = ⊢λ∶⸨ τ ⸩∙ (ê ◇⇐) [ τ₃▸ ∙ τ~̸τ₁ ∙ x ]
    ⊢←₁ ê₁ ∙ ě₂ [ x ] ◇⇐ = ⊢← (ê₁ ◇⇒) ∙ ě₂ [ x ]
    ⊢←₂ ě₁ ∙ ê₂ [ x ] ◇⇐ = ⊢← ě₁ ∙ (ê₂ ◇⇐) [ x ]
    (⊢ ê₁ ∙₁ ě₂ ∙ ě₃) ◇⇐ = ⊢ (ê₁ ◇⇐) ∙ ě₂ ∙ ě₃
    (⊢ ě₁ ∙₂ ê₂ ∙ ě₃) ◇⇐ = ⊢ ě₁ ∙ (ê₂ ◇⇐) ∙ ě₃
    (⊢ ě₁ ∙₃ ě₂ ∙ ê₃) ◇⇐ = ⊢ ě₁ ∙ ě₂ ∙ (ê₃ ◇⇐)
    ⊢⸨ ê ⸩[ τ~̸τ′ ∙ zsu ] ◇⇐ = ⊢⸨ ê ◇⇒ ⸩[ τ~̸τ′ ∙ (ZSu→MSu zsu) ]
    ⊢∙ ê [ τ~τ′ ∙ zsu ] ◇⇐ = ⊢∙ (ê ◇⇒) [ τ~τ′ ∙ (ZSu→MSu zsu) ]
