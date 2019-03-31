function [AUC,TPR,FPR] = evaluation(B0,B)

nb = size(B,1) + 1;
% 获得上三角矩阵
B0_triu = triu(B0,1);
B_triu = triu(B,1);
% 展成一维向量
B0_triu = B0_triu(:);
B_triu = B_triu(:);
% 定义
TPR = [];
FPR = [];
for e = eps:5e-2:max(abs(B_triu))
    % 获得原有节点电纳矩阵中的所有非零元
    IDX0 = find(B0_triu ~= 0);
    % 获得还原出的节点电纳矩阵中的非零元
    IDX = find(abs(B_triu) >= e);
    % 求两个数组的交集
    TP = length(intersect(IDX0,IDX));
    % 求两个数组的差集
    FP = length(setdiff(IDX,IDX0));
    % 交集占所有非零元的比例
    TPR = [TPR; TP/length(IDX0)];
    % 差集占零元的比例
    FPR = [FPR; FP/( (nb-1)*(nb-2)/2 - length(IDX0) + eps)];
end
AUC = sum(([1;FPR]-[FPR;0]).*([1;TPR] + [TPR;0])/2 );
end