library(ggplot2)
#Later we will learn how to read data from external files into R, but for now we are going to use a clean and ready-to-use dataset that is provided by the ratdat data package. To make our dataset available, we need to load this package too.

library(ratdat)
#The ratdat package contains data from the Portal Project, which is a long-term dataset from Portal, Arizona, in the Chihuahuan desert.

#We will be using a dataset called complete_old, which contains older years of survey data. Let’s try to learn a little bit about the data. We can use a ? in front of the name of the dataset, which will bring up the help page for the data.

?complete_old
#Here we can read descriptions of each variable in our data.

#To actually take a look at the data, we can use the View() function to open an interactive viewer, which behaves like a simplified version of a spreadsheet program. It’s a handy function, but somewhat limited when trying to view large datasets.

View(complete_old)
#Here we can read descriptions of each variable in our data.

#To actually take a look at the data, we can use the View() function to open an interactive viewer, which behaves like a simplified version of a spreadsheet program. It’s a handy function, but somewhat limited when trying to view large datasets.

str(complete_old)
#str() will tell us how many observations/rows (obs) and variables/columns we have, as well as some information about each of the variables. We see the name of a variable (such as year), followed by the kind of variable (int for integer, chr for character), and the first 10 entries in that variable. We will talk more about different data types and structures later on.

ggplot(data = complete_old)

#We get a blank plot because we haven’t told ggplot() which variables we want to correspond to parts of the plot. We can specify the “mapping” of variables to plot elements, such as x/y coordinates, size, or shape, by using the aes() function. We’ll also add a comment, which is any line starting with a #. It’s a good idea to use comments to organize your code or clarify what you are doing.

ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length))
#adding a mapping to x and y axes
#Now we’ve got a plot with x and y axes corresponding to variables from complete_old. However, we haven’t specified how we want the data to be displayed. We do this using geom_ functions, which specify the type of geometry we want, such as points, lines, or bars. We can add a geom_point() layer to our plot by using the + sign. We indent onto a new line to make it easier to read, and we have to end the first line with the + sign.

ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  +     geom_point()
  #Warning message:
    #Removed 3081 rows containing missing values or values outside the scale range (`geom_point()`). 
#You may notice a warning that missing values were removed. If a variable necessary to make the plot is missing from a given row of data (in this case, hindfoot_length or weight), it can’t be plotted. ggplot2 just uses a warning message to let us know that some rows couldn’t be plotted.

#A more serious type of message is an error. Here’s an example:
#ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) + geom_poit()
#Error in geom_poit(): could not find function "geom_poit"

#As you can see, we only get the error message, with no plot, because something has actually gone wrong. This particular error message is fairly common, and it happened because we misspelled point as poit. Because there is no function named geom_poit(), R tells us it can’t find a function with that name.

ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  +     geom_point(alpha = 0.2)
#Building ggplot plots is often an iterative process, so we’ll continue developing the scatter plot we just made. You may have noticed that parts of our scatter plot have many overlapping points, making it difficult to see all the data. We can adjust the transparency of the points using the alpha argument, which takes a value between 0 and 1:

ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  +     geom_point(alpha = 0.2, color = "blue")
#We can also change the color of the points.

#Two common issues you might run into when working in R are forgetting a closing bracket or a closing quote. Let’s take a look at what each one does.

#Try running the following code:
  

#ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  #geom_point(color = "blue", alpha = 0.2
             #You will see a + appear in your console. This is R telling you that it expects more input in order to finish running the code. It is missing a closing bracket to end the geom_point function call. You can hit Esc in the console to reset it.
             
             #Something similar will happen if you run the following code:
               
               
             #ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
               #geom_point(color = "blue, alpha = 0.2)
#A missing quote at the end of blue means that the rest of the code is treated as part of the quote, which is a bit easier to see since RStudio displays character strings in a different color.

#You will get a different error message if you run the following code:


#ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  #geom_point(color = "blue", alpha = 0.2))
#This time we have an extra closing ), which R doesn’t know what to do with. It tells you there is an unexpected ), but it doesn’t pinpoint exactly where. With enough time working in R, you will get better at spotting mismatched brackets.

#Adding another variable
#Let’s try coloring our points according to the sampling plot type (plot here refers to the physical area where rodents were sampled and has nothing to do with making graphs). Since we’re now mapping a variable (plot_type) to a component of the ggplot2 plot (color), we need to put the argument inside aes():

ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length, color = plot_type)) +
  geom_point(alpha = 0.2)

#Modifying Plots
#Challenge: Try modifying the plot so that the shape of the point varies by sex. You will set the shape the same way you set the color.

#ggplot(data = complete_old, 
       #mapping = aes(x = weight, y = hindfoot_length, shape = sex)) +
  #geom_point(alpha = 0.2)

#Challenge continued: Now try changing the plot so that the color of the points vary by year. Do you notice a difference in the color scale compared to changing color by plot type? Why do you think this happened?
#ggplot(data = complete_old, 
#mapping = aes(x = weight, y = hindfoot_length, color = year)) +
  #geom_point(alpha = 0.2)

#Changing Scales
#The default discrete color scale isn’t always ideal: it isn’t friendly to viewers with colorblindness and it doesn’t translate well to grayscale. However, ggplot2 comes with quite a few other color scales, including the fantastic viridis scales, which are designed to be colorblind and grayscale friendly. We can change scales by adding scale_ functions to our plots:


