# This file was generated, do not modify it. # hide
clf = machine(KNNClassifier(K=3), Xs, y)
fit!(clf, rows=train)
ŷ = predict_mode(clf, rows=test)

misclassification_rate(ŷ, y[test])