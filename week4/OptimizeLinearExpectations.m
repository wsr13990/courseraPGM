% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = OptimizeLinearExpectations( I )
  % Inputs: An influence diagram I with a single decision node and one or more utility nodes.
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return value: the maximum expected utility of I and an optimal decision rule 
  % (represented again as a factor) that yields that expected utility.
  % You may assume that there is a unique optimal decision.
  %
  % This is similar to OptimizeMEU except that we will have to account for
  % multiple utility factors.  We will do this by calculating the expected
  % utility factors and combining them, then optimizing with respect to that
  % combined expected utility factor.  
  MEU = [];
  OptimalDecisionRule = [];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  %
  % A decision rule for D assigns, for each joint assignment to D's parents, 
  % probability 1 to the best option from the EUF for that joint assignment 
  % to D's parents, and 0 otherwise.  Note that when D has no parents, it is
  % a degenerate case we can handle separately for convenience.
  expectedUtilities = [];
  ITemp = I;
  EU = [];
  if(length(I.UtilityFactors)==1)
    [MEU OptimalDecisionRule] = OptimizeMEU(I);
  elseif(length(I.UtilityFactors)>1)
    ITemp.UtilityFactors = I.UtilityFactors(1);
    EU = CalculateExpectedUtilityFactor(ITemp);
    for i = 2:length(I.UtilityFactors)
      ITemp.UtilityFactors = I.UtilityFactors(i);
      EU = FactorSum(EU, CalculateExpectedUtilityFactor(ITemp));
    end  
  end
  #Enumerate decisions & optimize MEU
  D = I.DecisionFactors(1);
  numberOfParentJoint = prod(D.card(2:length(D.var)));
  numberOfDecisions = D.card(1)^numberOfParentJoint;
  assignments = IndexToAssignment(1:numberOfDecisions,D.card(1).*ones(1,numberOfParentJoint));
  MEU = -inf;
  OptimalDecisionRule = D;
  for i=1:length(assignments)
    assignment = assignments(i,:);
    decision = [];
    for j=1:length(assignment)
      index = assignment(j);
      template = zeros(1,D.card);
      template(index)=1;
      decision = [decision template];
    end
    D.val = decision;
    currentMEU = sum(FactorProduct(EU,D).val);
    if (currentMEU > MEU)
      MEU = currentMEU;
      OptimalDecisionRule = D;
    end
  end
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  



end
