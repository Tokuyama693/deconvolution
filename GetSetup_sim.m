function output = Ex1_GetSetup_sim(n,FV)
    % -------- impulse response function --------
     for j = 1 : n
        t=j-1;
        h(j)=((1-exp(-FV))/FV)*exp(-FV*t);
     end
    ht=transpose(h);
   
    m=n;
    %output.ht = h;
    
    % -------- Define H matrix --------
    % Full matrix H
      Hfull = matrixH(ht,'zero'); % zero, periodic or reflexive
      output.Hfull = Hfull;
    
    %%%%%%%%%%%%%%%%%% choose O2 or CO2 %%%%%%%%%%%%%%%%%%%%%%%%%
    % ------ true observation output for O2 
    %rng(0)
    %gas=fopen('output_O2.txt');
    %bb=textscan(gas,'%f %f');
    %bb=cell2mat(bb);
    %bb=bb(:,2);

    %freshO2 = bb(1); % input freshO2 manually for experiment
    %for i=1:n
    %b(i,1)= freshO2-bb(i);%% for oxygen uptake
    %end
    %output.b = b;%%%% %
    %params.b=output.b;
    % ------ true observation for CO2
    rng(0)
    gas=fopen('output_CO2.txt');
    bb=textscan(gas,'%f %f');
    bb=cell2mat(bb);
    bb=bb(:,2);

    freshCO2 = bb(1); % input freshCO2 manually for experiment
    for i=1:n
    b(i,1)=bb(i)-freshCO2;%% for oxygen uptake
    end
    output.b = b;%%%% %
    params.b=output.b;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % -------- Regularization matrix
    % q11 = zeros(n,1); q11(1:2) = [1 -1]';
    % q12 = zeros(n,1); q12(1) = 1;
    % Q1 = toeplitz(q11,q12);
    
    q21 = zeros(n,1); q21(1:3)=[1 -2 1]';
    q22 = zeros(n,1); q22(1)=1;
    Q2 = toeplitz(q21,q22);      
    
    I = eye(n);
    
    % Choose regularization matrix Q 
    output.Q = Q2;
    
end