using Unitful, DataFrames, CSV, Plots
using EasyFit, Peaks, Symbolics, Latexify
using Statistics

rskvfull = 5.16u"cm"
rskvinn = 0.27u"cm"
r = rskvfull-rskvinn

data = CSV.read("data.csv", DataFrame)

data = data[data[!,1] .> -0.15,:]

plot(data[!,2],data[!,1])
savefig("data1line!.png")

skifamass = 122u"g"

k = fitlinear(data[!,2],data[!,1]).a

data2 = CSV.read("data2.csv", DataFrame)

data2 = data2 .- data2[end,2]

plot(data2[!,1], data2[!,2])

peaks = findmaxima(data2[!,2])
peaks = peaks[1][peaks[2] .> -10]

scatter!(data2[peaks,1],data2[peaks,2])
savefig("data2withmax.png")



plot(data2[!,1], abs.(data2[!,2]))
savefig("plotabsdata2.png")

##

τ2 = -k*data2[!,2]
b = diff(data2[!,2]) ./ τ2[1:end-1]
mean(skipmissing(b))

##

data3 = CSV.read("data3.csv", DataFrame)
data3 = data3 .- data3[end,2]
data4 = CSV.read("data4.csv", DataFrame)
data4 = data4 .- data4[end,2]


plot(data2[peaks,1][1:end-1], log.(data2[peaks,2][1:end-1]))

## hluti 2

function findErrorFromSym(symExpr; errorSuffix = "Err")
	vars = Symbolics.get_variables(symExpr)
	varErrs = []
	for i in vars
		push!(varErrs, Symbolics.variable(string(i,errorSuffix)))
	end
	Dvars = [expand_derivatives(Differential(i)(symExpr)) for i in vars]
	symErr = sqrt(sum((Dvars[i]*varErrs[i])^2 for i in eachindex(vars)))
	return symErr
end


