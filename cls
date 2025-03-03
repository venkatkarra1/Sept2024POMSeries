^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530   1) package com.qa.opencart.factory;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530   2) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530   3) import java.io.File;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530   4) import java.io.FileInputStream;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530   5) import java.io.FileNotFoundException;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530   6) import java.io.IOException;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530   7) import java.net.MalformedURLException;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530   8) import java.net.URL;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530   9) import java.util.Properties;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  10) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  11) import org.apache.logging.log4j.LogManager;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  12) import org.apache.logging.log4j.Logger;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  13) import org.openqa.selenium.OutputType;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  14) import org.openqa.selenium.TakesScreenshot;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  15) import org.openqa.selenium.WebDriver;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  16) import org.openqa.selenium.chrome.ChromeDriver;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  17) import org.openqa.selenium.edge.EdgeDriver;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  18) import org.openqa.selenium.firefox.FirefoxDriver;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  19) import org.openqa.selenium.io.FileHandler;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  20) import org.openqa.selenium.remote.RemoteWebDriver;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  21) import org.openqa.selenium.safari.SafariDriver;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  22) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  23) import com.qa.opencart.constants.AppConstants;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  24) import com.qa.opencart.exception.FrameworkException;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  25) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  26) import io.qameta.allure.Step;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  27) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  28) public class DriverFactory {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  29) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  30) 	WebDriver driver;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  31) 	Properties prop;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  32) 	OptionsManager optionsManager;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  33) 	public static String highlight;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  34) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  35) 	public static ThreadLocal<WebDriver> tlDriver = new ThreadLocal<WebDriver>();
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  36) 	private static final Logger log = LogManager.getLogger(DriverFactory.class);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  37) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  38) 	@Step("init the driver using properties : {0}")
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  39) 	public WebDriver initDriver(Properties prop) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  40) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  41) 		String browserName = prop.getProperty("browser");
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  42) 		// System.out.println("browser name is :" + browserName);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  43) 		log.info("browser name is : " + browserName);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  44) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  45) 		highlight = prop.getProperty("highlight");
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  46) 		optionsManager = new OptionsManager(prop);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  47) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  48) 		boolean remoteExecution = Boolean.parseBoolean(prop.getProperty("remote"));
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  49) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  50) 		switch (browserName.trim().toLowerCase()) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  51) 		case "chrome":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  52) 			if (remoteExecution) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  53) 				// run tcs on remote/grid:
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  54) 				initRemoteDriver("chrome");
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  55) 			} else {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  56) 				// local execution:
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  57) 				tlDriver.set(new ChromeDriver(optionsManager.getChromeOptions()));
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  58) 			}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  59) 			break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  60) 		case "firefox":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  61) 			if (remoteExecution) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  62) 				// run tcs on remote/grid:
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  63) 				initRemoteDriver("firefox");
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  64) 			} else {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  65) 				// local execution:
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  66) 				tlDriver.set(new FirefoxDriver(optionsManager.getFirefoxOptions()));
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  67) 			}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  68) 			break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  69) 		case "edge":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  70) 			if (remoteExecution) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  71) 				// run tcs on remote/grid:
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  72) 				initRemoteDriver("edge");
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  73) 			} else {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  74) 				// local execution:
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  75) 				tlDriver.set(new EdgeDriver(optionsManager.getEdgeOptions()));
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  76) 			}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  77) 			break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  78) 		case "safari":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  79) 			tlDriver.set(new SafariDriver());
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  80) 			break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  81) 		default:
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  82) 			log.error("plz pass the valid browser name.." + browserName);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  83) 			throw new FrameworkException("===invalid browser name===");
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  84) 		}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  85) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  86) 		getDriver().manage().deleteAllCookies();
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  87) 		getDriver().manage().window().maximize();
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  88) 		getDriver().get(prop.getProperty("url"));
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  89) 		return getDriver();
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  90) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  91) 	}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  92) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  93) 	/**
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  94) 	 * init the remote driver with selenium grid
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  95) 	 * 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  96) 	 * @param browserName
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  97) 	 */
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  98) 	private void initRemoteDriver(String browserName) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530  99) 		System.out.println("Running tests on grid: " + browserName);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 100) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 101) 		try {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 102) 			switch (browserName.toLowerCase().trim()) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 103) 			case "chrome":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 104) 				tlDriver.set(
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 105) 						new RemoteWebDriver(new URL(prop.getProperty("huburl")), optionsManager.getChromeOptions()));
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 106) 				break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 107) 			case "firefox":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 108) 				tlDriver.set(
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 109) 						new RemoteWebDriver(new URL(prop.getProperty("huburl")), optionsManager.getFirefoxOptions()));
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 110) 				break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 111) 			case "edge":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 112) 				tlDriver.set(new RemoteWebDriver(new URL(prop.getProperty("huburl")), optionsManager.getEdgeOptions()));
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 113) 				break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 114) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 115) 			default:
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 116) 				System.out.println("browser is not supported on GRID... " + browserName);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 117) 				break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 118) 			}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 119) 		} catch (MalformedURLException e) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 120) 			e.printStackTrace();
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 121) 		}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 122) 	}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 123) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 124) 	/**
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 125) 	 * get driver using threadlocal
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 126) 	 */
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 127) 	public static WebDriver getDriver() {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 128) 		return tlDriver.get();
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 129) 	}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 130) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 131) 	/**
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 132) 	 * This method is used to init the properties from .properties file
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 133) 	 * 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 134) 	 * @return
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 135) 	 */
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 136) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 137) 	// supply env name using maven command line
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 138) 	// mvn clean install -Denv="qa"
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 139) 	// mvn clean install
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 140) 	public Properties initProp() {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 141) 		String envName = System.getProperty("env");
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 142) 		// System.out.println("running test suite on env: " + envName);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 143) 		log.info("running test suite on env: " + envName);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 144) 		FileInputStream ip = null;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 145) 		prop = new Properties();
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 146) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 147) 		try {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 148) 			if (envName == null) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 149) 				// System.out.println("no env is passed, hence running test suite on qa env..");
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 150) 				log.warn("no env is passed, hence running test suite on qa env..");
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 151) 				ip = new FileInputStream(AppConstants.CONFIG_QA_PROP_FILE_PATH);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 152) 			} else {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 153) 				switch (envName.trim().toLowerCase()) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 154) 				case "qa":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 155) 					ip = new FileInputStream(AppConstants.CONFIG_QA_PROP_FILE_PATH);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 156) 					break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 157) 				case "dev":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 158) 					ip = new FileInputStream(AppConstants.CONFIG_DEV_PROP_FILE_PATH);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 159) 					break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 160) 				case "stage":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 161) 					ip = new FileInputStream(AppConstants.CONFIG_STAGE_PROP_FILE_PATH);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 162) 					break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 163) 				case "uat":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 164) 					ip = new FileInputStream(AppConstants.CONFIG_UAT_PROP_FILE_PATH);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 165) 					break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 166) 				case "prod":
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 167) 					ip = new FileInputStream(AppConstants.CONFIG_PROD_FILE_PATH);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 168) 					break;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 169) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 170) 				default:
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 171) 					// System.out.println("plz pass the right env name..."+ envName);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 172) 					log.error("plz pass the right env name..." + envName);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 173) 					throw new FrameworkException("===INVALID ENV===");
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 174) 				}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 175) 			}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 176) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 177) 			prop.load(ip);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 178) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 179) 		} catch (FileNotFoundException e) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 180) 			e.printStackTrace();
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 181) 			log.error(e.getMessage());
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 182) 		} catch (IOException e) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 183) 			e.printStackTrace();
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 184) 		}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 185) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 186) 		return prop;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 187) 	}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 188) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 189) 	/**
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 190) 	 * takescreenshot
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 191) 	 */
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 192) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 193) 	public static String getScreenshot() {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 194) 		File srcFile = ((TakesScreenshot) getDriver()).getScreenshotAs(OutputType.FILE);// temp dir
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 195) 		String path = System.getProperty("user.dir") + "/screenshot/" + "_" + System.currentTimeMillis() + ".png";
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 196) 		File destination = new File(path);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 197) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 198) 		try {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 199) 			FileHandler.copy(srcFile, destination);
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 200) 		} catch (IOException e) {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 201) 			e.printStackTrace();
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 202) 		}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 203) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 204) 		return path;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 205) 	}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 206) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 207) 	public static File getScreenshotFile() {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 208) 		File srcFile = ((TakesScreenshot) getDriver()).getScreenshotAs(OutputType.FILE);// temp dir
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 209) 		return srcFile;
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 210) 	}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 211) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 212) 	public static byte[] getScreenshotByte() {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 213) 		return ((TakesScreenshot) getDriver()).getScreenshotAs(OutputType.BYTES);// temp dir
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 214) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 215) 	}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 216) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 217) 	public static String getScreenshotBase64() {
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 218) 		return ((TakesScreenshot) getDriver()).getScreenshotAs(OutputType.BASE64);// temp dir
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 219) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 220) 	}
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 221) 
^b337924 (Venkat Karra 2025-03-01 11:10:31 +0530 222) }
