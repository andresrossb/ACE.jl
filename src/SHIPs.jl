
module SHIPs

using Reexport
@reexport using JuLIP

# external imports that are useful for all submodules
include("extimports.jl")


include("aux.jl")
include("prototypes.jl")


# basic polynomial building blocks
include("polynomials/sphericalharmonics.jl")
include("polynomials/transforms.jl"); @reexport using SHIPs.Transforms
include("polynomials/orthpolys.jl"); @reexport using SHIPs.OrthPolys


# The One-particle basis is the first proper building block
include("oneparticlebasis.jl")

# the permutation-invariant basis: this is a key building block
# for other bases but can also be a useful export itself
include("pibasis.jl")
# include("grapheval.jl")   # temporarily? Or permanently? ...
include("pipot.jl")

# rotation-invariant site potentials (incl the ACE model)
include("rpi/rpi.jl")
@reexport using SHIPs.RPI

# pair potentials + repulsion
include("pairpots/pair.jl");
@reexport using SHIPs.PairPotentials

# lots of stuff related to random samples:
#  - random configurations
#  - random potentials
#  ...
include("random.jl")
@reexport using SHIPs.Random


include("utils.jl")
@reexport using SHIPs.Utils

include("utils/importv5.jl")


include("compat/compat.jl")




include("export/export.jl")


# - bond model
# - pure basis
# - real basis
# - regularisers
# - descriptors
# - random potentials


end # module
