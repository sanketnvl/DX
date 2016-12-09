package com.myexample.utility;


//pdfbox-app-2.0.0-RC2.jar
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.security.Key;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Security;
import java.security.spec.RSAPrivateKeySpec;
import java.security.spec.RSAPublicKeySpec;
import java.util.Arrays;

import javax.crypto.Cipher;

import org.bouncycastle.jce.provider.BouncyCastleProvider;



/**
  * <p>Description: Utility class that helps encrypt and decrypt strings using RSA algorithm</p>
 */
public class RSASecurityPack
{
    protected  final String ALGORITHM = "RSA"; 
    public RSASecurityPack()
    {
    	init();
    }

    /**
     * Init java security to add BouncyCastle as an RSA provider
     */
    public  void init()
    {
        Security.addProvider(new BouncyCastleProvider());       
    }

    /**
     * Generate key which contains a pair of private and public key using 1024 bytes
     * @return key pair
     * @throws NoSuchAlgorithmException
     */
    public  KeyPair generateKey() throws NoSuchAlgorithmException
    {
        KeyPairGenerator keyGen = KeyPairGenerator.getInstance(ALGORITHM);
        keyGen.initialize(1024);
        KeyPair key = keyGen.generateKeyPair();
        return key;
    }
    /**
     * Encrypt a text using public key.
     * @param text The original unencrypted text
     * @param key The public key
     * @return Encrypted text
     * @throws java.lang.Exception
     */
    public  byte[] encrypt(byte[] text, PublicKey key) throws Exception
    {
        byte[] cipherText = null;
        try
        {
            //
            // get an RSA cipher object and print the provider
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");  
            // encrypt the plaintext using the public key
            cipher.init(Cipher.ENCRYPT_MODE, key);
            cipherText = cipher.doFinal(text);
        }
        catch (Exception e)
        {
            System.err.println(e);
            throw e;
        }
        return cipherText;
    } 

    /**
     * Decrypt text using private key
     * @param text The encrypted text
     * @param key The private key
     * @return The unencrypted text
     * @throws java.lang.Exception
     */
    public  byte[] decrypt(byte[] text, PrivateKey key) throws Exception
    {
        byte[] dectyptedText = null;
        try
        {
            // decrypt the text using the private key
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");            
            cipher.init(Cipher.DECRYPT_MODE, key);
            dectyptedText = cipher.doFinal(text);
        }
        catch (Exception e)
        {
        	System.err.println(e);
            throw e;
        }
        return dectyptedText;

    }

    /**
     * Encrypt file using 1024 RSA encryption    
     * @param srcFileName Source file name
     * @param destFileName Destination file name
     * @param key The key. For encryption this is the Private Key and for decryption this is the public key
     * @param cipherMode Cipher Mode
     * @throws Exception
     */
    public  void encryptFile(String srcFileName, String destFileName, PublicKey key) throws Exception
    {
        encryptDecryptFile(srcFileName,destFileName, key, Cipher.ENCRYPT_MODE);
    }

    /**
     * Decrypt file using 1024 RSA encryption
     * @param srcFileName Source file name
     * @param destFileName Destination file name
     * @param key The key. For decryption this is the public key
     * @param cipherMode Cipher Mode
     * @throws Exception
     */
    public  void decryptFile(String srcFileName, String destFileName, PrivateKey key) throws Exception
    {
        encryptDecryptFile(srcFileName,destFileName, key, Cipher.DECRYPT_MODE);
    }

    /**
     * Encrypt and Decrypt files using 1024 RSA encryption
     *
     * @param srcFileName Source file name
     * @param destFileName Destination file name
     * @param key The key. For encryption this is the Private Key
     * @param cipherMode Cipher Mode
     * @throws Exception
     */
    private  void encryptDecryptFile(String srcFileName, String destFileName, Key key, int cipherMode) throws Exception
    {
    	
        OutputStream outputWriter = null;
        InputStream inputReader = null;
        try
        {
            Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");           
            //RSA encryption data size limitations are slightly less than the key modulus size,
            //depending on the actual padding scheme used (e.g. with 1024 bit (128 byte) RSA key,
            //the size limit is 117 bytes for PKCS#1 v 1.5 padding.
            byte[] buf = cipherMode == Cipher.ENCRYPT_MODE? new byte[100] : new byte[128];
            int bufl;
            // init the Cipher object for Encryption...
            cipher.init(cipherMode, key);

            // start FileIO
            outputWriter = new FileOutputStream(destFileName);
            inputReader = new FileInputStream(srcFileName);
            while ( (bufl = inputReader.read(buf)) != -1)
            {
                byte[] encText = null;
                if (cipherMode == Cipher.ENCRYPT_MODE)
                {                	
                      encText = encrypt(copyBytes(buf,bufl),(PublicKey)key);
                }
                else
                {
                    encText = decrypt(copyBytes(buf,bufl),(PrivateKey)key);
                }
                outputWriter.write(encText);                
            }
            outputWriter.flush();

        }
        catch (Exception e)
        {
        	System.err.println(e);
            throw e;
        }
        finally
        {
            try
            {
                if (outputWriter != null)
                {
                    outputWriter.close();
                }
                if (inputReader != null)
                {
                    inputReader.close();
                }
            }
            catch (Exception e)
            {
                // do nothing...
            } // end of inner try, catch (Exception)...
        }
    }

    private  byte[] copyBytes(byte[] arr, int length)
    {
        byte[] newArr = null;
        if (arr.length == length)
        {
            newArr = arr;
        }
        else
        {
            newArr = new byte[length];
            for (int i = 0; i < length; i++)
            {
                newArr[i] = (byte) arr[i];
            }
        }
        return newArr;
    }	
	/**
     * Save a key into specified file 'fileName'
     * @param fileName Name of file to save key(private or public)
     * @param mod Modulus   
     * @param exp Exponent(private or public)
     * @throws IOException
     */
    public  void saveKeyToFile(String fileName, BigInteger mod, BigInteger exp) throws IOException {
		ObjectOutputStream fileOut = new ObjectOutputStream(new BufferedOutputStream(new FileOutputStream(fileName)));
		  try {
			 fileOut.writeObject(mod);
			 fileOut.writeObject(exp);
		  } 
		  catch (Exception e) {
			  throw new IOException("Unexpected error");
		  } 
		  finally {
			 fileOut.close();
		  }
	}
    /**
     * Read a key from specified file 'keyFileName'
     * @param keyFileName Name of file to read key(private or public)    
     * @throws IOException
     */
    public Key readKeyFromFile(String keyFileName,String keyType) throws IOException { 
		InputStream in = new FileInputStream(keyFileName);
		ObjectInputStream oin = new ObjectInputStream(new BufferedInputStream(in));
		  try {
			BigInteger m = (BigInteger) oin.readObject();
			BigInteger e = (BigInteger) oin.readObject();
			KeyFactory fact = KeyFactory.getInstance("RSA");
			if (keyType.startsWith("public"))
				return fact.generatePublic(new RSAPublicKeySpec(m, e));
			else
				return fact.generatePrivate(new RSAPrivateKeySpec(m, e));
		  } 
		  catch (Exception e) {
		    throw new RuntimeException("serialisation error", e);
		  } 
		  finally {
		    oin.close();
		  }
	}
	/**
     * compareFile files for verification  
     * @param orignalFileName Original source file name
     * @param decryptedFileName Retrieved source file from encrypted file name   
     * @return boolean value either true if both specified files having same content or false.
     * @throws Exception
     */
	@SuppressWarnings("resource")
	public  boolean compareFile(String orignalFileName, String decryptedFileName) throws Exception
	 {
		InputStream firstInputReader = null;
		InputStream secondInputReader = null;
		try {
			firstInputReader = new FileInputStream(orignalFileName);
			secondInputReader = new FileInputStream(decryptedFileName);
			int fLength = firstInputReader.available();
			int sLength = secondInputReader.available();			
			byte[] fbuf = new byte[fLength];
			byte[] sbuf = new byte[sLength];
			while (firstInputReader.read(fbuf)!= -1	&& secondInputReader.read(sbuf) != -1) {
				if (!Arrays.equals(fbuf, sbuf))
					return false;
			}

		} catch (Exception e) {
			System.err.println(e);
			throw e;
		} finally {
			
			try {
				if (firstInputReader != null) {
					firstInputReader.close();
				}
				if (secondInputReader != null) {
					secondInputReader.close();
				}
			} catch (Exception e) {
				// do nothing...
			} 
			
		}

		return true;
	}
	 

		public static void main(String arg[]) {/*
			
			RSASecurityPack rs = new RSASecurityPack();
			try {
				
				KeyPair key = rs.generateKey();

				PublicKey publicKey = key.getPublic();
				PrivateKey privateKey = key.getPrivate();

				System.out.println("keys are created");

				KeyFactory fact = KeyFactory.getInstance("RSA");
				RSAPublicKeySpec pub = fact.getKeySpec(publicKey,RSAPublicKeySpec.class);
				RSAPrivateKeySpec priv = fact.getKeySpec(privateKey,RSAPrivateKeySpec.class);

				rs.saveKeyToFile("public.key", pub.getModulus(), pub.getPublicExponent());
				rs.saveKeyToFile("private.key", priv.getModulus(), priv.getPrivateExponent());
				System.out.println("keys are saved");

				// ====================================================
				publicKey = (PublicKey) rs.readKeyFromFile("public.key","public");
				privateKey = (PrivateKey) rs.readKeyFromFile("private.key","private");

				fact = KeyFactory.getInstance("RSA");
				pub = fact.getKeySpec(publicKey, RSAPublicKeySpec.class);
				priv = fact.getKeySpec(privateKey, RSAPrivateKeySpec.class);
				System.out.println("============Keys are retrived==========");
				System.out.println("==========Start Encryption=============");
				rs.encryptFile("IOM.pdf", "IOM_enc.pdf", publicKey);
				System.out.println("==========Start Decryption=============");
				rs.decryptFile("IOM_enc.pdf", "IOM_dec.pdf", privateKey);

				System.out.println("Done");
				System.out.println("Verification Test...");
				System.out.println(rs.compareFile("IOM.pdf", "IOM_dec.pdf"));
			} catch (Exception e) {			
				e.printStackTrace();
			}
		*/}	 
		
		public void encryption(String filePath,String dest,String filename)
		{
			

			RSASecurityPack rs = new RSASecurityPack();
			try {
				
				KeyPair key = rs.generateKey();

				PublicKey publicKey = key.getPublic();
				PrivateKey privateKey = key.getPrivate();

				System.out.println("keys are created");

				KeyFactory fact = KeyFactory.getInstance("RSA");
				RSAPublicKeySpec pub = fact.getKeySpec(publicKey,RSAPublicKeySpec.class);
				RSAPrivateKeySpec priv = fact.getKeySpec(privateKey,RSAPrivateKeySpec.class);

				/*rs.saveKeyToFile("public.key", pub.getModulus(), pub.getPublicExponent());
				rs.saveKeyToFile("private.key", priv.getModulus(), priv.getPrivateExponent());
				System.out.println("keys are saved");*/

				// ====================================================
				publicKey = (PublicKey) rs.readKeyFromFile("public.key","public");
				privateKey = (PrivateKey) rs.readKeyFromFile("private.key","private");

				fact = KeyFactory.getInstance("RSA");
				pub = fact.getKeySpec(publicKey, RSAPublicKeySpec.class);
				priv = fact.getKeySpec(privateKey, RSAPrivateKeySpec.class);
				System.out.println("============Keys are retrived==========");
				
				System.out.println("==========Start Encryption=============");		
				rs.encryptFile(filePath, dest+"encryption/"+filename, publicKey);
				
			} catch (Exception e) {			
				e.printStackTrace();
			}
		}
		
		public boolean decryption(String fname)
		{
			String fpath = "D:/sourceHOV/";
			boolean flag = false;
			RSASecurityPack rs = new RSASecurityPack();
			try {
				
				KeyPair key = rs.generateKey();

				PublicKey publicKey = key.getPublic();
				PrivateKey privateKey = key.getPrivate();

				System.out.println("keys are created");

				KeyFactory fact = KeyFactory.getInstance("RSA");
				RSAPublicKeySpec pub = fact.getKeySpec(publicKey,RSAPublicKeySpec.class);
				RSAPrivateKeySpec priv = fact.getKeySpec(privateKey,RSAPrivateKeySpec.class);

		

				// ====================================================
				publicKey = (PublicKey) rs.readKeyFromFile("public.key","public");
				privateKey = (PrivateKey) rs.readKeyFromFile("private.key","private");

				fact = KeyFactory.getInstance("RSA");
				pub = fact.getKeySpec(publicKey, RSAPublicKeySpec.class);
				priv = fact.getKeySpec(privateKey, RSAPrivateKeySpec.class);
				System.out.println("============Keys are retrived==========");
				
				
				System.out.println("==========Start Decryption=============");
				//rs.decryptFile("IOM_enc.pdf", "IOM_dec.pdf", privateKey);
				rs.decryptFile(fpath+"encryption/"+fname, fpath+"decryption/"+fname, privateKey);
				//rs.decryptFile("D:/sourceHOV/encryption/IOM.pdf", fpath+"decryption/"+fname, privateKey);
				
				System.out.println("Done");
				System.out.println("Verification Test...");
				//System.out.println(rs.compareFile("IOM.pdf", "IOM_dec.pdf"));
				flag= rs.compareFile(fpath+"original/"+fname, fpath+"decryption/"+fname);
				System.out.println(flag);
			} catch (Exception e) {	
				flag = false;
				e.printStackTrace();
			}
			return flag;
		}
		
}
