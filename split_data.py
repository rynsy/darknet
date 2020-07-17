import glob, os

# Current directory
current_dir = os.path.dirname(os.path.abspath(__file__))

print(current_dir)

data_path = current_dir + '/images'
config_path = current_dir + '/cfg'

# Percentage of images to be used for the test set
percentage_test = 10;

# Create and/or truncate train.txt and test.txt
file_train = open(config_path + '/' + 'breath-train.txt', 'w')  
file_test = open(config_path + '/' + 'breath-test.txt', 'w')# Populate train.txt and test.txt
counter = 1  
index_test = round(100 / percentage_test)  
for pathAndFilename in glob.iglob(os.path.join(data_path, "*.jpg")):  
    title, ext = os.path.splitext(os.path.basename(pathAndFilename))
    if counter == index_test:
        counter = 1
        file_test.write(data_path + "/" + title + '.jpg' + "\n")
    else:
        file_train.write(data_path + "/" + title + '.jpg' + "\n")
        counter = counter + 1
