using XLSX

xf = XLSX.readxlsx("Corriente_THD.xlsx")
sheet = xf["Corriente_THD"]

frec = zeros(401)
Ifiltro = zeros(401)

i = 2
str = string("")
k = 1
while sheet[i,1] != "END"
    global k = 1
    global str = string("")
    for j in sheet[i,1]
        if j == ','
            if k == 1
                global frec[i-1] = parse(Float64,str)
            elseif k == 2
                global Ifiltro[i-1] = parse(Float64,str)
            end
            global str = string("")
            global k = k + 1
        else
            global str = string(str,j)
        end
    end
    global Ifiltro[i-1] = parse(Float64,str)
    global i = i + 1
end


XLSX.openxlsx("WTHD3Corriente.xlsx", mode="w") do wf
    wfile = wf[1]
    
    for i in 1:length(frec)
        wfile[i,1] = frec[i]
        wfile[i,2] = Ifiltro[i]
    end
end

