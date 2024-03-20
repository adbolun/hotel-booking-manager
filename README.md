# hotel-booking-manager

Web application: application that allows a user to rent an apartment for a well-established period of time. The apartment can be chosen depending on several factors: cost, size, status. Only the currently available apartments can be seen by the client. The administrator decides to accept the user's request or not.

### Launch

```
Apache Tomcat 9 is required to run

Before the first launch, run sql scripts to create and initialize tables in the database
The scripts are located in the resources directory
```

### application.properties configuration

```
#Connection settings
db.url=jdbc:postgresql://localhost:5432/hotel_repository?currentSchema=hotel_schema
db.username=
db.password=
db.driver=org.postgresql.Driver

#Connection pool size
db.pool.size=25

#Image base url
image.base.url=/Users/Admin/work/images/
```
