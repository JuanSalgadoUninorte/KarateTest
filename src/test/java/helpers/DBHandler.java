package helpers;

import net.minidev.json.JSONObject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBHandler {
    private static String connectionURL = "jdbc:mysql://localhost:3306/newtestkarate";
    private static String password = "";
    private static String user = "root";

    public static void addNewJobWithName(String jobName) {
        try (Connection connect = DriverManager.getConnection(connectionURL, user, password)) {
            connect.createStatement().execute("INSERT INTO jobs (job_desc, min_lvl, max_lvl) VALUES ('" + jobName + "', 80, 120)");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static JSONObject getMinAndMaxLevelsForJob(String jobName) {
        JSONObject json = new JSONObject();
        try (Connection connect = DriverManager.getConnection(connectionURL, user, password)) {
            ResultSet rs = connect.createStatement().executeQuery("SELECT * FROM jobs where job_desc = '" + jobName + "'");
            rs.next();
            json.put("minLvl", rs.getString("min_lvl"));
            json.put("maxLvl", rs.getString("max_lvl"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return json;
    }
}