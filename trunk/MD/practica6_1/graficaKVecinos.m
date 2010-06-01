



for i = 1:20
    
    error(1) = calculo_error_KNN(i,'10kfoldoriginal/bank/bank_kfcv_train01.arff','10kfoldoriginal/bank/bank_kfcv_test01.arff');
    error(2) = calculo_error_KNN(i,'10kfoldoriginal/bank/bank_kfcv_train02.arff','10kfoldoriginal/bank/bank_kfcv_test02.arff');
    error(3) = calculo_error_KNN(i,'10kfoldoriginal/bank/bank_kfcv_train03.arff','10kfoldoriginal/bank/bank_kfcv_test03.arff');
    error(4) = calculo_error_KNN(i,'10kfoldoriginal/bank/bank_kfcv_train04.arff','10kfoldoriginal/bank/bank_kfcv_test04.arff');
    error(5) = calculo_error_KNN(i,'10kfoldoriginal/bank/bank_kfcv_train05.arff','10kfoldoriginal/bank/bank_kfcv_test05.arff');
    error(6) = calculo_error_KNN(i,'10kfoldoriginal/bank/bank_kfcv_train06.arff','10kfoldoriginal/bank/bank_kfcv_test06.arff');
    error(7) = calculo_error_KNN(i,'10kfoldoriginal/bank/bank_kfcv_train07.arff','10kfoldoriginal/bank/bank_kfcv_test07.arff');
    error(8) = calculo_error_KNN(i,'10kfoldoriginal/bank/bank_kfcv_train08.arff','10kfoldoriginal/bank/bank_kfcv_test08.arff');
    error(9) = calculo_error_KNN(i,'10kfoldoriginal/bank/bank_kfcv_train09.arff','10kfoldoriginal/bank/bank_kfcv_test09.arff');
    error(10) = calculo_error_KNN(i,'10kfoldoriginal/bank/bank_kfcv_train10.arff','10kfoldoriginal/bank/bank_kfcv_test10.arff');
    
    grafica(i) = mean(error);
end;

plot([1:20],grafica);