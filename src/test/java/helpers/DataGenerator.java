package helpers;

import com.github.javafaker.Faker;

import java.util.Locale;

public class DataGenerator {
    public static String getRandomEmail() {
        Faker faker = new Faker();
        String email = faker.name().fullName().toLowerCase(Locale.ROOT) + faker.random().nextInt(0, 100)+"@testj.com";
        return email;
    }
    public static String getRandomUsername() {
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }
    public String getRandomUsernameNonStatic() {
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }
}
