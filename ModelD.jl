using JuMP, GLPK, GLPKMathProgInterface
#ModelD = Model(solver = GLPKSolverMIP())
ModelD = Model(GLPK.Optimizer)

#a = 1:4
t = 1:4
w = 1:2
l = 1:4

#NP = 18
#A = a
T = t
W = w
L =l
@variable(ModelD,eh[L,T,W]>=0)

for w = 1:2, l = 1:4, t = 1:4
    if  4 < 18
        h3 = @constraint(ModelD,eh[l,t,w] <= eh[l,t,w])#21
        println(h3)
    end
end


#Parameters
CR = [11, 12]
CO =[50, 51]
WA = [1, 2, 1, 2]
RHE = [150, 151]

#Variables
@variable(ModelD,r[A,T]>=0)
@variable(ModelD,o[A,T]>=0)
@variable(ModelD,wr[W,T]>=0)
@variable(ModelD,er[W,T]>=0)
@variable(ModelD,r_aux[T])

#Variavél auxiliar
@variable(ModelD, r_aux[T])

@objective(ModelD,Min,sum(CR[WA[a]]*(r[a,t]+o[a,t])+CO[WA[a]]*o[a,t] for a in A, t in T))

for w = 1:2, t= 1:4#
    m = @constraint(ModelD,sum(r[a,t] for a in A) +wr[w,t] ==RHE[w])#*er[w,t])#26 Atualizada
    #println(m)
end

print(ModelD)#imprime o modelo para verificação
status = solve(ModelD)#retorna o status do processo de otimização relatado pelo solucionador
println("Objective value:  ", JuMP.getobjectivevalue(ModelD))

println("r =  ", JuMP.getvalue(r))
#println("o = ", JuMP.getvalue(o))
println("wr = ", JuMP.getvalue(wr))
#println("er = ", JuMP.getvalue(er))

#value = CSV.read("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv", DataFrame)
#valueresult = DataFrame(value =JuMP.getvalue(r))
#CSV.write("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv",valueresult)

#df = DataFrame(value = Int[0;0;0;0])
#df2 = DataFrame(value = "r:2 dimensions:")
#println(df)
#println(df2)

open("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv", "w") do io
    for a = 1:4, t= 1:4
        println(io,join([getvalue(r[a,t])], ", "))
        #println(io,join([getvalue(x[a,t])], ", "))
        #println(io,join([getvalue(o[a,t])], ", "))
        #println(io,join([getvalue(s[a,t])], ", "))
    end
end

open("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv","w") do io
    for t = 1:size(Periodos,1)
        jj=r_aux = getvalue(sum([(r[a,t])] for a in A))
        println(jj)
        println(io,join(r_aux))
    end
end


pp = getvalue(r[a,t])
CSV.write("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv", pp

Tables.table(pp)


for t= 1:4
    j = r_aux = sum(r[a,t] for a in A)
    println(j)
end




p = readline("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv")
#p = readdlm("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv")
println(p)



######################################################################################3
df = DataFrame(value = Float64[150.0; 150.0; 150.0; 150], value2 = Float64[151.0; 151.0; 151.0; 151.0])
i = [150.0 151.0; 150.0 151.0]
j = [151.0 151.0; 151.0 151.0]
open("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv", "w") do io
    for t = 1:4
    writedlm(io, join([getvalue(r[a, t]) for a in A], ","))
    writedlm(io, [i,j])
    #for t = 1:size(Periodos,1)
    #    jj=r_aux = getvalue(sum([(r[a,t])] for a in A))
    #    println(jj)
    #    println(io,join(r_aux))
    end
end
CSV.write("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv", DataFrame(i))
u =readdlm("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv",Float64)
println(u)
println(df)

##################################################################################################
arr = [150.0 150.0 151.0 151.0]
df = reshape(arr, 2,2) |> DataFrame
CSV.write("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv", df)
println(df)






#@objective(ModeloDeterministico,Min,sum(CR[w]*(r[a,t]+o[a,t])+CO[w]*o[a,t] for w in W, a in A, t in T)+sum(CR[w]*(wr[w,t]+wo[w,t])+CO[w]*wo[w,t] for w in W, t in T)+sum(PS[i]*(1-d[i]) for i in I))

#Symbol = tipo de objeto usado para representar identificadores no código
#Any = união de todos os tipos. Possui a propriedade definidora
#Dict = ??
#jump_vars = Dict{Symbol, Any}()
#@variable(ModeloDeterministico,c[A], lower_bound=0,Bin)#1 se a atividade "a" for processada internamente, 0 caso contrário
#@variable(ModeloDeterministico,c1[A],Bin)#1 se a atividade "a" for processada internamente, 0 caso contrário
#jump_vars[:c] = @variable(ModeloDeterministico,c[A],Bin)#1 se a atividade "a" for processada internamente, 0 caso contrário



####################################ROBUSTA


#@objective(ModeloDeterministico,Max,sum(QDaw*x[a,t]*k[a,t] for a in A))

##Parâmetros que possuem dois índices/Matrizes
#QDaw = [878 0; 0 1131; 100 0; 0 200]
#GAMAwt = []









#Criando um Dataframe
#Resultado = CSV.read("C:\\Users\\raquel.santos\\Desktop\\Bd_ReduzidoModeloDeterministico\\Planilha_Dados_Resultados.csv", DataFrame)

#Imprime os resultados das variáveis de decisão
#cuurent_name = nome atual da variavel, "x"
#current_var = variavel atual
for (current_name, current_var) in jump_vars
    println("$current_name =  ", JuMP.getvalue(current_var))
end


Resultados = DataFrame(resultadovariaveis =JuMP.getvalue(current_var))#zeros(4))
Resultados2 = DataFrame(resultadovariaveis = JuMP.getvalue(r))
Resultados3 = DataFrame(variaveis= o,resultadovariaveis = JuMP.getvalue(o))

CSV.write("C:\\Users\\raquel.santos\\Desktop\\Bd_ReduzidoModeloDeterministico\\Planilha_Dados_Resultados.csv",R)
CSV.write("C:\\Users\\raquel.santos\\Desktop\\Bd_ReduzidoModeloDeterministico\\Planilha_Dados_ResultadosV2.csv",Resultados2)
CSV.write("C:\\Users\\raquel.santos\\Desktop\\Bd_ReduzidoModeloDeterministico\\Planilha_Dados_ResultadosV3.csv",Resultados3)
pp = jump_results = JuMP.getvalue(s)#, JuMP.getvalue(r), JuMP.getvalue(o)

R = DataFrame([JuMP.getvalue(s)])

#for row in CSV.write("C:\\Users\\raquel.santos\\Desktop\\Bd_ReduzidoModeloDeterministico\\Planilha_Dados_Resultados.csv")
#    Resultado[c,:resultadovariaveis] = JuMP.getvalue(jump_vars[:c])
    #println("c  = ", JuMP.getvalue(jump_vars[:d]))
    #print(" c = $(JuMP.getvalue(c))")
#end


#getsolvetime(ModeloDeterministico)
#internalmodel(ModeloDeterministico)


#println("Objective value: ", getObjectivevalue(ModeloDeterministico))
#println("x1 = ", getValue(x1))
#println("x2 = ", getValue(x2))



JuMP.value.(ModeloDeterministico)
JuMP.optimize(ModeloDeterministico)
optimize!(ModeloDeterministico)
println("Valor objetivo: ",JuMP.objective_value(ModeloDeterministico))
termination_status(ModeloDeterministico)#status do modelo


primal_status(ModeloDeterministico)
start_value(ModeloDeterministico)


#open("C:\\Users\\raquel.santos\\Desktop\\testemodel_s.csv", "w") do io
#    for a = 1:size(Atividades,1), t= 1:size(Periodos,1)
#        println(io, join([getvalue(s[a,t])], ", "))
#    end
#end

#eixo x = período de tempo
#     y = número de hrs trabalhadas
#open("C:\\Users\\raquel.santos\\Desktop\\testemodel.csv", "w") do io
#    for a = 1:size(Atividades,1), t= 1:size(Periodos,1)
        #println(io,join([getvalue(r[a,t])], ", "))
        #println(io,join([getvalue(x[a,t])], ", "))
        #println(io,join([getvalue(o[a,t])], ", "))
        #println(io,join([getvalue(s[a,t])], ", "))
#    end
#end
