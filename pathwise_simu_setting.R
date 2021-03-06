##################################################################################

# Includes Power simulation settings

##################################################################################


##### loading required packages
source("~/hdi_path/bin/pathwise_require.R")
###### 


dataGen = function(setting = 'dep', ...){
	if(setting == 'dep'){

		return(depenDesign(...))

		}else if (setting == 'other'){
		continue 
		#### add more settings here
	}

}



depenDesign = function(n, p, beta, rho){

	if(rho == 'equl'){  # equi corr
    	Sigma = matrix(rep(0.8,p*p),p,p)
    	diag(Sigma) = rep(1,p)

    	Mu=rep(0,p)
		X=rmvnorm(n,mean=Mu,sigma=Sigma)
		Y <- X %*% beta + rnorm(n,0,1)   
   
		}else if (rho == "weak_equl"){
				
				Sigma = matrix(rep(0.5,p*p),p,p)
    			diag(Sigma) = rep(1,p)

    			Mu=rep(0,p)
				X=rmvnorm(n,mean=Mu,sigma=Sigma)
				Y <- X %*% beta + rnorm(n,0,1)   
   
			}else if (rho > 0){  # toeplitz matrix

    		Sigma = toeplitz( rho^(0:(p - 1)) )

    		
    		Mu = rep(0,p)
			#X = rmvnorm(n,mean = Mu,sigma = Sigma)
			X = rmvn(n, mu = Mu,sigma = Sigma)
			Y <- X %*% beta + rnorm(n,0,1)  

			}else if (rho == 0){  # independent

				X <- matrix(rnorm(n*p),nrow=n)
				Y <- X %*% beta + rnorm(n,0,1)
			
			}


	return(list(X = X, Y = Y))   

}


# Setting 2