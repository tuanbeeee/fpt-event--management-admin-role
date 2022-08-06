/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author light
 */
public class DBUtils {

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection conn = null;

        //Connect Postgresql Online - Heroku
//        Class.forName("org.postgresql.Driver");
//        String url = "jdbc:postgresql://ec2-34-242-8-97.eu-west-1.compute.amazonaws.com:5432/df3n5hked56o4k?sslmode=require"; //encrypt=true;trustServerCertificate=true;";
//        conn = DriverManager.getConnection(url, "xkzgjbnhefjign", "5fad21744f1f3750c9cb0ba80e1dd3f1f2adf579583b72a2a98dd34c017438be");
//Connect Postgresql Local
        Class.forName("org.postgresql.Driver");
        String url = "jdbc:postgresql://localhost:5432/FPT-EVENT-MANAGEMENT-FIX"; //";
        conn = DriverManager.getConnection(url, "postgres", "029801");
//      
//Connect SQL Server
//        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//        String url = "jdbc:sqlserver://localhost:1433;databaseName=FPT_EVENT_MANAGEMENT; encrypt=true;trustServerCertificate=true;";
//        conn = DriverManager.getConnection(url, "sa", "1");  
//        Class.forName("org.postgresql.Driver");
//        String url = "jdbc:postgresql://postgresql-84712-0.cloudclusters.net:16874/FPT-EVENT-MANAGEMENT?sslmode=require"; //";
//        conn = DriverManager.getConnection(url, "admin", "hoanghai2907");

        return conn;
    }
}
