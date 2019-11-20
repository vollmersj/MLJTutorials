# This file was generated, do not modify it.

using MLJ

@load LinearRegressor pkg=MLJLinearModels

using RDatasets, DataFrames
boston = dataset("MASS", "Boston")
first(boston, 3)

describe(boston, :mean, :std, :eltype)

using ScientificTypes
data = coerce(boston, autotype(boston, :discrete_to_continuous));

y = data.MedV
X = select(data, Not(:MedV));

mdl = LinearRegressor()

mach = machine(mdl, X, y)
fit!(mach)

fp = fitted_params(mach)
@show round.(fp.coefs[1:3], sigdigits=3)
@show round(fp.intercept, sigdigits=3)

ŷ = predict(mach, X)
round(rms(ŷ, y), sigdigits=4)

using PyPlot

figure(figsize=(8,6))
res = ŷ .- y
stem(res)

savefig("assets/literate/ISL-lab-3-res.svg") # hide

figure(figsize=(8,6))
hist(res, density=true)
x = range(-20, 20, )

savefig("assets/literate/ISL-lab-3-res2.svg") # hide

X2 = hcat(X, X.LStat .* X.Age);

rename!(X2, :x1 => :interaction);

mach = machine(mdl, X2, y)
fit!(mach)
ŷ = predict(mach, X2)
round(rms(ŷ, y), sigdigits=4)

X3 = hcat(X.LStat, X.LStat.^2)
machine(mdl, X3, y)
fit!(mach)
ŷ = predict(mach, X3)
round(rms(ŷ, y), sigdigits=4)

