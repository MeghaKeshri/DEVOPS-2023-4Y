package com.example.studentmanagement.selenium;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;

public class BasicLoginTest {

    public static void main(String[] args) {
        String browser = System.getProperty("browser", "chrome");

        WebDriver driver = null;

        try {
            if ("firefox".equals(browser)) {
                WebDriverManager.firefoxdriver().setup();
                FirefoxOptions options = new FirefoxOptions();
                options.addArguments("--headless");
                driver = new FirefoxDriver(options);
            } else {
                WebDriverManager.chromedriver().setup();
                ChromeOptions options = new ChromeOptions();
                options.addArguments("--headless", "--no-sandbox", "--disable-dev-shm-usage");
                driver = new ChromeDriver(options);
            }

            driver.get("http://localhost:8080/login");
            driver.findElement(By.name("username")).sendKeys("admin");
            driver.findElement(By.name("password")).sendKeys("admin");
            driver.findElement(By.cssSelector("button[type='submit']")).click();

            String title = driver.getTitle();
            System.out.println("TEST PASSED on " + browser.toUpperCase() + " -> Page: " + title);

        } catch (Exception e) {
            System.out.println("TEST FAILED: " + e.getMessage());
            e.printStackTrace();
        } finally {
            if (driver != null) driver.quit();
        }
    }
}