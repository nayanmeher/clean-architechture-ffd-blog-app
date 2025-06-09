# clean_architechtrue_blog_app

A new Flutter project, with clean architechture and with bloc, supabase, hive, getIt

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Steps to Clean Architecture:

Folder Structure of feature first approach : 
    lib 
       - feature
            - auth
                - data
                    - datasource
                    - repository
                - domain
                    - repository
                    - useCases
                - presentation 
                    - bloc
                    - pages
                    - widgets


> first we have to create the pages for presentation layer. 
# we should work with the 2nd layer, which is domain layer. 
    > In domain layer we have to write the abstract interface class for our features. 
    > There we can define the interface with Either return type. It contains the core business logic and rule.
    > And abstract class needs to be created in domain layer and its impl needs to be created in data layer.
    > domain layer should not depends on any other layer. 
    ex : abstract interface class AuthRepository{
            Future<Either<Failure, String> signupWithPassword({
                       required, String name, 
                       required String email, 
                       required String password
                       }) // function closing
            } // class closing
# After defining the base interface for our repository classes, we need to work on our 3rd layer,i.e Data layer. 
    > In data layer we need to create our datasource which may be our api or local db. 
    > For datasource we also need to create interface 
        ex: abstract interface class AuthRemoteDataSource{
                Future<String> signUpWithPassword({ 
                    required String name, required String email, required String password
                })                               
    > Then in the same class we will implement the implementation methods for datasource
        ex: class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
                // Api calls --> 
            }
# Then we need to implement the abstract interface of domain layer repository
    > In this implementatin we need to call the method of AuthRemoteDataSourceImpl

