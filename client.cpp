using System; 
using System.Collections.Generic; 
using System.Linq; 
using System.Net; 
using System.Text; 
using System.Threading.Tasks; 
using static System.Console; 
using System.IO;


namespace Client

{
	class Program
	{
		static Socket socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
		static byte[] buffer = new byte[1024];
		static MemoryStream stream = new MemoryStream(buffer); /*поток данных, хранящихся в памяти*/
		static BinaryWriter writer = new BinaryWriter(stream); /*для записи данных в поток*/

		static void Main(string[] args)
		{
			Title = 'Client';
			socket.Connect("127.0.0.1", 194);
			//
			writer.Write("login"); //login
			writer.Write("password"); //login, password 

			ReadLine();

			socket.Send(buffer);
		}
	}
}


