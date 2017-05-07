
load('dataset_M.mat');
m_data = dataset;
load('dataset_O.mat');
o_data = dataset;

%display scatter plot

scatter(o_data(:,1),o_data(:,2),6,'r'),hold on;;
scatter(m_data(:,1),m_data(:,2),6,'b');
% Number of observations of each class
n1=size(m_data,1);
n2=size(o_data,1);

%Mean of each class
c1 = [m_data(:,1) m_data(:,2)];
c2 = [o_data(:,1) o_data(:,2)];
mu1=mean(c1);
mu2=mean(c2);

% Average of the mean of all classes
mu=(mu1+mu2)/2;

% Center the data (data-mean)
d1=c1-repmat(mu1,size(c1,1),1);
d2=c2-repmat(mu2,size(c2,1),1);


% Calculate the within class variance (SW)
s1 = d1' * d1;
s2 = d2' * d2;
sw = s1 + s2;
invsw = inv(sw);

% W is for reducing the dimensionality to genrate non-linear transform
w = invsw * (mu2-mu1)';
save('W.mat','w');
backup = [-0.7936 0.8899];