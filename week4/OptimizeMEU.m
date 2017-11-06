% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeMEU( I )

  % Inputs: An influence diagram I with a single decision node and a single utility node.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  
  % We assume I has a single decision node.
  % You may assume that there is a unique optimal decision.
  D = I.DecisionFactors(1);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE...
  % 
  % Some other information that might be useful for some implementations
  % (note that there are multiple ways to implement this):
  % 1.  It is probably easiest to think of two cases - D has parents and D 
  %     has no parents.
  % 2.  You may find the Matlab/Octave function setdiff useful.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  R = I.RandomFactors;
  D = I.DecisionFactors;
  U = I.UtilityFactors;
  EU = CalculateExpectedUtilityFactor(I);
  if (length(I.DecisionFactors.var)==1)#D has no parent
    MEU = max(EU.val);
    OptimalDecisionRule = D;
    OptimalDecisionRule.val = (EU.val == MEU);
  elseif (length(I.DecisionFactors.var) > 1)#D has parent
    numOfJointDecisionParent = prod(D.card(2:length(D.card)));
    OptimalDecisionRule = D;
    MEU = 0;
    for i = 0:(length(EU.val)/numOfJointDecisionParent)-1
      maxEUPerParent = max(EU.val(numOfJointDecisionParent*i+1:(i+1)*numOfJointDecisionParent));
      MEU = MEU + maxEUPerParent;
      OptimalDecisionRule.val(numOfJointDecisionParent*i+1:(i+1)*numOfJointDecisionParent) = (EU.val(numOfJointDecisionParent*i+1:(i+1)*numOfJointDecisionParent)== maxEUPerParent);
    end
  end
end
