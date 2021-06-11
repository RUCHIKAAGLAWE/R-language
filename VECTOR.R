#------VECTORS------#
vec_num<-c(10,50,49)
vec_num
class(vec_num)

vec_chr<-c("w","e","r")
vec_chr
class(vec_chr)

vec_bool<-c("TRUE","TRUE","FALSE")
vec_bool
class(vec_bool)


vec_random<-c(1,5.7,TRUE)
vec_random
class(vec_random)

#OBJECT PROPERTIES
v1= 1:100
class(v1)
typeof(v1)

v2=letters[1:10]
class(v2)
typeof(v2)
length(v2)

#ARITHMATIC CALCULATION OF VECTOR
vect_1<-c(4,6,5)
vect_2<-c(4,7,6)
#sum
sum_vect<-vect_1+vect_2
sum_vect

#Slicing vector
slice_vector<-c(1,2,3,4,5,6,7,8,9,10)
slice_vector[1:2]

c(1:10)

#apply logical operators on vector
logical_vector<-c(1:10)
logical_vector>5

logical_vector[(logical_vector>5)]

#print 3 and 4
logical_vector[(logical_vector>2) & (logical_vector<5)]

#access element
(x=seq(0,12,by=3))


x[4]
x[c(4,5)]
x[-1]
x[c(2,-4)]

x[c(2.4,3.56)]

#MODIFY

(X=-3:2)
X[2]<-0;
X

X[X<0]=5;
X

X=X[1:4];
X

#DELEAT VECTOR
(X=seq(1,2,length.out = 10))

x=NULL
X
X[4]