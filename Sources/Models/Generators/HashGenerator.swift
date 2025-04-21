import CryptoKit

import struct Foundation.Data

struct HashGenerator {
    var algorithm = HashAlgorithm.md5
    var isUppercase = false
    var outputType = HashOutputType.hex
    var hmacKey = ""

    func generate(_ input: String) -> String {
        guard !input.isEmpty else { return "" }
        let inputData = Data(input.utf8)
        let outputData: Data
        if self.hmacKey.isEmpty {
            outputData =
                switch self.algorithm {
                case .md5: Data(Insecure.MD5.hash(data: inputData))
                case .sha1: Data(Insecure.SHA1.hash(data: inputData))
                case .sha256: Data(SHA256.hash(data: inputData))
                case .sha384: Data(SHA384.hash(data: inputData))
                case .sha512: Data(SHA512.hash(data: inputData))
                }
        } else {
            let key = SymmetricKey(data: Data(self.hmacKey.utf8))
            outputData =
                switch self.algorithm {
                case .md5: Data(HMAC<Insecure.MD5>.authenticationCode(for: inputData, using: key))
                case .sha1:
                    Data(HMAC<Insecure.SHA1>.authenticationCode(for: inputData, using: key))
                case .sha256: Data(HMAC<SHA256>.authenticationCode(for: inputData, using: key))
                case .sha384: Data(HMAC<SHA384>.authenticationCode(for: inputData, using: key))
                case .sha512: Data(HMAC<SHA512>.authenticationCode(for: inputData, using: key))
                }
        }
        switch self.outputType {
        case .hex:
            let format = self.isUppercase ? "%02X" : "%02x"
            return outputData.lazy
                .map { String(format: format, $0) }
                .joined()
        case .base64:
            return outputData.base64EncodedString()
        }
    }
}

#if TESTING_ENABLED
    import PlaygroundTester

    @objcMembers
    final class HashGeneratorTests: TestCase {
        func testGenerateMD5() {
            var generator = HashGenerator()
            generator.algorithm = .md5
            AssertEqual("", other: generator.generate(""))
            AssertEqual("7215ee9c7d9dc229d2921a40e899ec5f", other: generator.generate(" "))
            AssertEqual(
                "b9a4f035019096a2f939352b369258bc",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateMD5Uppercase() {
            var generator = HashGenerator()
            generator.algorithm = .md5
            generator.isUppercase = true
            AssertEqual("", other: generator.generate(""))
            AssertEqual("7215EE9C7D9DC229D2921A40E899EC5F", other: generator.generate(" "))
            AssertEqual(
                "B9A4F035019096A2F939352B369258BC",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateMD5Base64() {
            var generator = HashGenerator()
            generator.algorithm = .md5
            generator.outputType = .base64
            AssertEqual("", other: generator.generate(""))
            AssertEqual("chXunH2dwinSkhpA6JnsXw==", other: generator.generate(" "))
            AssertEqual(
                "uaTwNQGQlqL5OTUrNpJYvA==",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA1() {
            var generator = HashGenerator()
            generator.algorithm = .sha1
            AssertEqual("", other: generator.generate(""))
            AssertEqual("b858cb282617fb0956d960215c8e84d1ccf909c6", other: generator.generate(" "))
            AssertEqual(
                "8fa581f55caecb0bc1da080202f64836b146aa40",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA1Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha1
            generator.outputType = .base64
            AssertEqual("", other: generator.generate(""))
            AssertEqual("uFjLKCYX+wlW2WAhXI6E0cz5CcY=", other: generator.generate(" "))
            AssertEqual(
                "j6WB9VyuywvB2ggCAvZINrFGqkA=",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA256() {
            var generator = HashGenerator()
            generator.algorithm = .sha256
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "36a9e7f1c95b82ffb99743e0c5c4ce95d83c9a430aac59f84ef3cbfab6145068",
                other: generator.generate(" ")
            )
            AssertEqual(
                "472f86ad5b7bcd90eff6147fd6f8fb755ac3b1ab8bf712e6a19467f5d6bfafd3",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA256Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha256
            generator.outputType = .base64
            AssertEqual("", other: generator.generate(""))
            AssertEqual("Nqnn8clbgv+5l0PgxcTOldg8mkMKrFn4TvPL+rYUUGg=", other: generator.generate(" "))
            AssertEqual(
                "Ry+GrVt7zZDv9hR/1vj7dVrDsauL9xLmoZRn9da/r9M=",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA384() {
            var generator = HashGenerator()
            generator.algorithm = .sha384
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "588016eb10045dd85834d67d187d6b97858f38c58c690320c4a64e0c2f92eebd9f1bd74de256e8268815905159449566",
                other: generator.generate(" ")
            )
            AssertEqual(
                "d8d70b6d20a02a4ec4de87f9047faef0dc467f049480043e954514be843d68950e6f8a20a6debe3bcd3bb4889a646590",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA384Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha384
            generator.outputType = .base64
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "WIAW6xAEXdhYNNZ9GH1rl4WPOMWMaQMgxKZODC+S7r2fG9dN4lboJogVkFFZRJVm",
                other: generator.generate(" ")
            )
            AssertEqual(
                "2NcLbSCgKk7E3of5BH+u8NxGfwSUgAQ+lUUUvoQ9aJUOb4ogpt6+O807tIiaZGWQ",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA512() {
            var generator = HashGenerator()
            generator.algorithm = .sha512
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "f90ddd77e400dfe6a3fcf479b00b1ee29e7015c5bb8cd70f5f15b4886cc339275ff553fc8a053f8ddc7324f45168cffaf81f8c3ac93996f6536eef38e5e40768",
                other: generator.generate(" ")
            )
            AssertEqual(
                "1b5e4b2ea5e1e23c5649ece43bf3e674b7a90b3fc71a54badf3b7841ebe7e223da976f092f44adf04a2494199abfb6aa1d23ec11d0296210d6f76cd76d943ec7",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateSHA512Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha512
            generator.outputType = .base64
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "+Q3dd+QA3+aj/PR5sAse4p5wFcW7jNcPXxW0iGzDOSdf9VP8igU/jdxzJPRRaM/6+B+MOsk5lvZTbu845eQHaA==",
                other: generator.generate(" ")
            )
            AssertEqual(
                "G15LLqXh4jxWSezkO/PmdLepCz/HGlS63zt4Qevn4iPal28JL0St8EoklBmav7aqHSPsEdApYhDW92zXbZQ+xw==",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateHMACMD5() {
            var generator = HashGenerator()
            generator.algorithm = .md5
            generator.hmacKey = " "
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "32f0e5f36a9ca3b8ddf4cf57a2aac3c2",
                other: generator.generate(" ")
            )
            generator.hmacKey = "Hello"
            AssertEqual(
                "0ca4313eae971e463ee36ef076d6726e",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateHMACMD5Base64() {
            var generator = HashGenerator()
            generator.algorithm = .md5
            generator.outputType = .base64
            generator.hmacKey = " "
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "MvDl82qco7jd9M9XoqrDwg==",
                other: generator.generate(" ")
            )
            generator.hmacKey = "Hello"
            AssertEqual(
                "DKQxPq6XHkY+427wdtZybg==",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateHMACSHA1() {
            var generator = HashGenerator()
            generator.algorithm = .sha1
            generator.hmacKey = " "
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "2062093078d9b904982597b6a67b14abc8512864",
                other: generator.generate(" ")
            )
            generator.hmacKey = "Hello"
            AssertEqual(
                "330ef8f4a6fc3bb4fd1d5be9d77bcaf4a1527c4b",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateHMACSHA1Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha1
            generator.outputType = .base64
            generator.hmacKey = " "
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "IGIJMHjZuQSYJZe2pnsUq8hRKGQ=",
                other: generator.generate(" ")
            )
            generator.hmacKey = "Hello"
            AssertEqual(
                "Mw749Kb8O7T9HVvp13vK9KFSfEs=",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateHMACSHA256() {
            var generator = HashGenerator()
            generator.algorithm = .sha256
            generator.hmacKey = " "
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "1352c6b2598324a5fb3ad64097ca2d678ddb71d906aa994e2fd0678e0be361aa",
                other: generator.generate(" ")
            )
            generator.hmacKey = "Hello"
            AssertEqual(
                "48e34698037cc06234bacd88da6f76976647fc869f4d62dde15aee41a7a568cf",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateHMACSHA256Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha256
            generator.outputType = .base64
            generator.hmacKey = " "
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "E1LGslmDJKX7OtZAl8otZ43bcdkGqplOL9BnjgvjYao=",
                other: generator.generate(" ")
            )
            generator.hmacKey = "Hello"
            AssertEqual(
                "SONGmAN8wGI0us2I2m92l2ZH/IafTWLd4VruQaelaM8=",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateHMACSHA384() {
            var generator = HashGenerator()
            generator.algorithm = .sha384
            generator.hmacKey = " "
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "1eeb28a5c16df6704aa5b452f43ed420cd032d43c86d40c37ba4739b7fbf04f586764edec88b13c2dd3530d15c5211b9",
                other: generator.generate(" ")
            )
            generator.hmacKey = "Hello"
            AssertEqual(
                "7220e5c1e34ba4905c9bc160e2d3c5e2ed63473d6362f293441f7b072cf3832826a302f8462caee97545bfe0b58d4cd6",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateHMACSHA384Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha384
            generator.outputType = .base64
            generator.hmacKey = " "
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "HusopcFt9nBKpbRS9D7UIM0DLUPIbUDDe6Rzm3+/BPWGdk7eyIsTwt01MNFcUhG5",
                other: generator.generate(" ")
            )
            generator.hmacKey = "Hello"
            AssertEqual(
                "ciDlweNLpJBcm8Fg4tPF4u1jRz1jYvKTRB97ByzzgygmowL4Riyu6XVFv+C1jUzW",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateHMACSHA512() {
            var generator = HashGenerator()
            generator.algorithm = .sha512
            generator.hmacKey = " "
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "0b8a72163b925bbb61ffa98e90339e57f0ed5c8956665af83691aebbdebb87e7eb6090a877b62fdcfca2e29768159d0066e7ef875a87d6a8b2ff9d286a98ff56",
                other: generator.generate(" ")
            )
            generator.hmacKey = "Hello"
            AssertEqual(
                "b73897f5e28bcadd25a6673b2f2f662148d820217fdf24070af0a06e6cfe707b18a482263b2081f1f69f05c571d279a19e55769db7726960841747dcbc338a24",
                other: generator.generate("Hello there !")
            )
        }

        func testGenerateHMACSHA512Base64() {
            var generator = HashGenerator()
            generator.algorithm = .sha512
            generator.outputType = .base64
            generator.hmacKey = " "
            AssertEqual("", other: generator.generate(""))
            AssertEqual(
                "C4pyFjuSW7th/6mOkDOeV/DtXIlWZlr4NpGuu967h+frYJCod7Yv3Pyi4pdoFZ0AZufvh1qH1qiy/50oapj/Vg==",
                other: generator.generate(" ")
            )
            generator.hmacKey = "Hello"
            AssertEqual(
                "tziX9eKLyt0lpmc7Ly9mIUjYICF/3yQHCvCgbmz+cHsYpIImOyCB8fafBcVx0nmhnlV2nbdyaWCEF0fcvDOKJA==",
                other: generator.generate("Hello there !")
            )
        }
    }
#endif
