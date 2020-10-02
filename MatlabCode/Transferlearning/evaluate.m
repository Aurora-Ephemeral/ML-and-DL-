function evaluate(Ypredict,Response)
%accuracy
accuracy=mean(Ypredict==Response);
fprintf('the accuracy of prediction is: %8.5f \n',accuracy);
%show the confusion matrix
figure('Units','normalized','Position',[0.2 0.2 0.4 0.4]);
cm = confusionchart(Response,Ypredict);
cm.Title = 'Confusion Matrix for Test Data';
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
ylabel('Observation');
xlabel('Prediction');
set(gca,'FontSize',36,'Fontname', 'Times New Roman');
fprintf('-------total Transferlearning process completed--------\n');
end
