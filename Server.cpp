using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using static System.Console;
using System.IO;


namespace Server

{
	class Program
	{
		static Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
		static byte[] buffer = new byte[1024];
		static MemoryStream stream = new MemoryStream(buffer); /*поток данных хранящихся в памяти*/
		static BinaryReader reader = new BinaryReader(stream);

		static void Main(string[] args)
		{
			Title = "Server";
			socket.Bind(new IPEndPoint(IPAddress.Any, 904));
			socket.Listen(5);

			Socket client = socket.Accept();
			client.Recieve(buffer);//|login, password  /*в трех случаях показаны расположения курсора после считывания*/

			string login = reader.ReadString();//login,| password 
			string password = reader.ReadString(); //login, password |

			WriteLine(login);
			WriteLine(password);

			stream.Position = 0; //|login, password

			ReadLine();
		}
	}
}
