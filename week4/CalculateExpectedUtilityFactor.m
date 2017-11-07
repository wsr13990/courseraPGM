% Copyright (C) Daphne Koller, Stanford University, 2012

function EUF = CalculateExpectedUtilityFactor( I )

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: A factor over the scope of the decision rule D from I that
  % gives the conditional utility given each assignment for D.var
  %
  % Note - We assume I has a single decision node and utility node.
  EUF = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE...
  R = I.RandomFactors;
  U = I.UtilityFactors;
  var = unique([R(:).var, U(:).var]);
  var = setdiff(var,I.DecisionFactors.var);
  EUF = VariableElimination([R U],var);
  if(length(R)==1)
    EUF = VariableElimination([R U],var);
  elseif (length(R)>1)
    RTemp = R(1);
    for i=2:length(R)
      RTemp = FactorProduct(RTemp,R(i));
    end
    EUF = VariableElimination(FactorProduct(RTemp,U),var);
  end
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  


  
end  
