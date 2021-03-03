
# --------------------------------------------------------------------------
# ACE.jl: Julia implementation of the Atomic Cluster Expansion
# Copyright (c) 2019 Christoph Ortner <christophortner0@gmail.com>
# All rights reserved.
# --------------------------------------------------------------------------


module Utils

import ACE

import ACE: PolyTransform, transformed_jacobi, Rn1pBasis,
            NaiveTotalDegree, init1pspec!, Ylm1pBasis,
            Product1pBasis

# import ACE.PairPotentials: PolyPairBasis

# - simple ways to construct a radial basis
# - construct a descriptor
# - simple wrappers to generate RPI basis functions (ACE + relatives)


function Rn_basis(;
      # transform parameters
      r0 = 1.0,
      trans = PolyTransform(2, r0),
      # degree parameters
      D = NaiveTotalDegree(),
      maxdeg = 6,
      # radial basis parameters
      rcut = 2.5,
      rin = 0.5 * r0,
      pcut = 2,
      pin = 0,
      constants = false)

   J = transformed_jacobi(maxdeg, trans, rcut, rin; pcut=pcut, pin=pin)
   return Rn1pBasis(J)
end

function RnYlm_1pbasis(; maxdeg=6, kwargs...)
   Rn = Rn_basis(; maxdeg = maxdeg)
   Ylm = Ylm1pBasis(maxdeg)
   B1p = ACE.Product1pBasis((Rn, Ylm))
   init1pspec!(B1p)
   return B1p
end


invariant_basis(; kwargs...) =
      symm_basis(ACE.Invariant(); kwargs...)

symm_basis(φ; maxν = 3, maxdeg = 6, kwargs...) =
      ACE.SymmetricBasis(φ,
                         RnYlm_1pbasis(; maxdeg=maxdeg, kwargs...),
                         ACE.One1pBasis(),
                         maxν,
                         maxdeg)

# function rpi_basis(; species = :X, N = 3,
#       # transform parameters
#       r0 = 2.5,
#       trans = PolyTransform(2, r0),
#       # degree parameters
#       D = SparsePSHDegree(),
#       maxdeg = 8,
#       # radial basis parameters
#       rcut = 5.0,
#       rin = 0.5 * r0,
#       pcut = 2,
#       pin = 0,
#       constants = false,
#       rbasis = transformed_jacobi(get_maxn(D, maxdeg, species), trans, rcut, rin;
#                                   pcut=pcut, pin=pin),
#       # one-particle basis
#       Basis1p = RnYlm1pBasis,
#       basis1p = Basis1p(rbasis; species = species, D = D) )
#
#    return RPIBasis(basis1p, N, D, maxdeg, constants)
# end
#
# descriptor = rpi_basis
# ace_basis = rpi_basis
#
# function pair_basis(; species = :X,
#       # transform parameters
#       r0 = 2.5,
#       trans = PolyTransform(2, r0),
#       # degree parameters
#       maxdeg = 8,
#       # radial basis parameters
#       rcut = 5.0,
#       rin = 0.5 * r0,
#       pcut = 2,
#       pin = 0,
#       rbasis = transformed_jacobi(maxdeg, trans, rcut, rin; pcut=pcut, pin=pin))
#
#    return PolyPairBasis(rbasis, species)
# end




end
