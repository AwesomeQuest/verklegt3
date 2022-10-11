using Unitful, DataFrames, CSV, Plots, EasyFit, Peaks

rskvfull = 5.16u"cm"
rskvinn = 0.27u"cm"
r = rskvfull-rskvinn

data = CSV.read("data.csv", DataFrame)

data = data[data[!,1] .> -0.15,:]

plot(data[!,2],data[!,1])
savefig("data1line!.png")

skifamass = 122u"g"

data2 = CSV.read("data2.csv", DataFrame)

data2 = data2 .- data2[end,2]

plot(data2[!,1], data2[!,2])

peaks = findmaxima(data2[!,2])
peaks = peaks[1][peaks[2] .> -10]

scatter!(data2[peaks,1],data2[peaks,2])
savefig("data2withmax.png")



plot(data2[!,1], abs.(data2[!,2]))
savefig("plotabsdata2.png")

plot(data2[peaks,1],log.(data2[peaks,2])[1:end-2])

# data3 = CSV.read("data3.csv", DataFrame)
# data4 = CSV.read("data4.csv", DataFrame)





