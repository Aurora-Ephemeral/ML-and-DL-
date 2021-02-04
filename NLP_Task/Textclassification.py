import pandas as pd
import WordFreq
import string
from nltk.corpus import stopwords
from sklearn.feature_extraction.text import CountVectorizer,TfidfTransformer
from sklearn.linear_model import SGDClassifier
from showprocess import ProgressBar
import numpy as np



def clean_text(X):
    """ text cleaning of the dataset

    Retrieves original dataset. For each piece of tweet removes the punctuation and specific token such as hyperlink.
    Detects the type of language for each element in the input argument and removes the stopping words respectively.

    Args:
         X: n_sample list, original tweets

    Return:
        X_for_preprocess: n_sample list, cleaning text for further preprocessing

    """

    progess_bar = ProgressBar(len(X))   # set a progress bar to show the processing status:
    print('cleaning process\n')
    for i,s in enumerate(X):
        progess_bar.update(i)
        s_no_punct=s.translate(str.maketrans('','',string.punctuation))  # removes the punctuation
        s_token = s_no_punct.split()
        s_no_url = [
                    token.lower() for token in s_token if (token.isalnum()
                    and (not (token.startswith('https')))
                    and token != 'amp'
                    and not token.isdigit())
                    ]  # removes specific tokens such as hyperlink, number and 'amp'
        X[i] = s_no_url

    clf_lang = WordFreq.WordFreq()
    stopwords_eng = set(stopwords.words('english'))
    stopwords_ger = set(stopwords.words('german'))

    # detect the language type and remove the stopping words respectively
    # detecting method is based on the principle of comparing word frequency in the homework 4

    for i,s in enumerate(X):
        s_lang_type = clf_lang.guess_language(s)
        if s_lang_type == 'English':
            s_no_sws = [t for t in s if t not in stopwords_eng]
        elif s_lang_type =='German_Deutsch':
            s_no_sws = [t for t in s if t not in stopwords_ger]
        else:
            raise TypeError('Wrong type of language occurs, please check the data set')
        X[i] = [' '.join(s_no_sws)]
    X_for_preprocess = []

    for s in X:
        X_for_preprocess.append(s[0])

    return X_for_preprocess

def sklearn_preprocessing(X_clean,cv=None,tfidf=None):
    """ feature generation from cleaning text based on the bag of the word principle

    Generates the features from cleaning text. Convert a collection of text documents to a matrix of token counts.
    Chooses the single token, bigram and trigram as countered target(features).

    Args:
        X_clean: n list, cleaning text of the dataset
        cv: CountVectorizer class, pretrained sklearn CountVectorizer. Argument is required only if the X_clean is
            dev/test set to be counted.
        tfidf: TfidfTransformer class, pretrained sklearn TfidfTransformer. Argument is required only if the X_clean is
            dev/test set to be computed

    Return:
        X_vect: (n_sample, n_features) csr_matrix, feature array of dataset
        cv: CounterVectorizer class, pretrained CountVectorizer class based on the train set
        tfidf: TfidfTransformer class, pretrained TfidfTransformer class based on the train set

    """

    # create a countvectorizer and tfidftransformer based on the train set.
    # Caution: Here the tfidf process is not executed, because the final performance after tdidf is not good

    if cv == None and tfidf ==None:
        cv = CountVectorizer(ngram_range=(1,3),stop_words='english')
        X_vect = cv.fit_transform(X_clean)
        tfidf = TfidfTransformer()
        X_tfidf = tfidf.fit_transform(X_vect)
        return X_vect, cv, tfidf

    # if the argument cv and tfidf are retrieved, treats the dataset as dev/testset.
    # executes the feature generation process with pretrained CountVectorizer and TfidfTransformer
    # Caution: Here the tfidf process is not executed, because the final performance after tdidf is not good

    else:
        X_vect = cv.transform(X_clean)
        X_tfidf = tfidf.transform(X_vect)

        return X_vect

def model_training(X_preprocessed,y):
    """ training a classifier based on the train set
    train a classifier based on the generated feature. Here the classifier is selected as SGDclassifier in third-party
    library sklearn

    Args:
        X_preprocessed: (n_sample, n_features) csr_matrix, feature array of data set
        y: (n_sample,) Dataframeseries, label of train set

    Return:
        clf_class: SGDclassifier class, pretrained classifier
    """


    clf_class = SGDClassifier()
    clf_class.fit(X_preprocessed,y)
    predict_train = clf_class.predict(X_preprocessed)
    accuracy_train = np.mean(predict_train == y)
    print('model accuracy based on train set is:{}%'.format(accuracy_train*100))  # show the model accuracy

    return clf_class

def evaluate(X_test_preprocessed,clf):
    """

    Args:
        X_test_preprocessed: (n_sample, n_features) csr_matrix, feature array of data set
        clf: SGDClassifier class, pretrained SGDclassifier

    Return: (n_sample,) numpy array, predict label of the dev/test set

    """

    return clf.predict(X_test_preprocessed)

if __name__ == '__main__':

    path_train = 'dataset_for_shared_task\\dataset_for_shared_task\\trainset.csv'
    path_dev = 'dataset_for_shared_task\\dataset_for_shared_task\\testset.csv'

    # Training a model based on train data:

    df_train = pd.read_csv(path_train,sep=',')
    df_train = df_train[['text','label']]
    X_train =df_train['text'].tolist()
    y_train = df_train['label']
    y_train = y_train.replace(3,2)
    X_train_clean = clean_text(X_train)
    X_train_preprocessed,cv,tfidf = sklearn_preprocessing(X_train_clean)
    clf = model_training(X_train_preprocessed,y_train)

    # Tuning and evaluating the classifier based on the dev/test set

    df_dev = pd.read_csv(path_dev,sep=',')
    X_dev = df_dev['text'].tolist()
    X_dev_clean = clean_text(X_dev)
    X_dev_preprocessed = sklearn_preprocessing(X_dev_clean,cv=cv,tfidf=tfidf)
    predict_result = evaluate(X_dev_preprocessed,clf)

    # Reformatting the prediction and save in a csv file

    df_result = pd.DataFrame(predict_result,columns=['label'])
    df_result.to_csv('answer.csv',index=False)

