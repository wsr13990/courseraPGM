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
  EU = CalculateExpectedUtilityFactor(I)
  #Enumerate decisions & Optimize MEU
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
end
