function [AUC,TPR,FPR] = evaluation(B0,B)

nb = size(B,1) + 1;
% ��������Ǿ���
B0_triu = triu(B0,1);
B_triu = triu(B,1);
% չ��һά����
B0_triu = B0_triu(:);
B_triu = B_triu(:);
% ����
TPR = [];
FPR = [];
for e = eps:5e-2:max(abs(B_triu))
    % ���ԭ�нڵ���ɾ����е����з���Ԫ
    IDX0 = find(B0_triu ~= 0);
    % ��û�ԭ���Ľڵ���ɾ����еķ���Ԫ
    IDX = find(abs(B_triu) >= e);
    % ����������Ľ���
    TP = length(intersect(IDX0,IDX));
    % ����������Ĳ
    FP = length(setdiff(IDX,IDX0));
    % ����ռ���з���Ԫ�ı���
    TPR = [TPR; TP/length(IDX0)];
    % �ռ��Ԫ�ı���
    FPR = [FPR; FP/( (nb-1)*(nb-2)/2 - length(IDX0) + eps)];
end
AUC = sum(([1;FPR]-[FPR;0]).*([1;TPR] + [TPR;0])/2 );
end