//
//  KamusTableViewController.swift
//  KamusApp
//
//  Created by Jun  on 11/9/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class KamusTableViewController: UITableViewController {

    
    var indoSelected:String?
    var inggrisSelected:String?
    
    let KamusURL = "http://localhost/KamusApp/index.php/api/getAllKamus"
    
    var kamuss = [Kamus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //membuat
        getKamus()
        //mengatur tinggi row table menjadi 92
        tableView.estimatedRowHeight = 92.0
        //mengatur tinggi row table menjadi dimensi otomatis
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return kamuss.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! KamusTableViewCell

        // Configure the cell...
        //memasukan nilainya kedalam masing 2 label
        cell.inggrisdesc.text = kamuss[indexPath.row].kamus_inggris
        cell.indodesc.text = kamuss[indexPath.row].kamus_idonesia
        
        let data = kamuss[indexPath.row]

        return cell
    }
    // MARK: - JSON PArsing
    // membuat method baru dengan nama: getLstestLoans()
    func getKamus() {
        
        //deklarsi LoanUrl untuk memanggil variable kivaLoanURL yang telah dideklarasikan sebelumnya
        guard let KamusUrl = URL(string: KamusURL) else {
            return //return ini memiliki ffungsi untuk mengembalikan nilai yang sudah di dapat ketika memanggil variable loanUrl
        }
        
        //delarasi request untuk request URL loanUrl
        let request = URLRequest(url: KamusUrl)
        //deklarasi task untuk mengambil data dari variable request diatas
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            //mengecek apakah ada error apa tidak
            if let error = error {
                //kondisi ketika ada error
                //mencetak error
                print(error)
                return //mengambil nilai error yang didapat
            }
            //parse JSON data
            //deklarasi variable data untuk mengambil data
            if let data = data {
                //pada bagian ini akan memanggil method parseJsonData yang akan kita buat di bawah
                self.kamuss = self.parseJsonData(data: data)
                
                //Reload TAble view
                OperationQueue.main.addOperation ({
                    //reload Data kembali
                    self.tableView.reloadData()
                })
            }
            
        })
        //task akan melakukan resume untuk memanggil data json nya
        task.resume()
    }
    //membuat method baru dengan nama ParseJsonData
    //method ini akan melakukan parsing data Json
    func parseJsonData(data: Data) -> [Kamus] {
        //deklarasi variable loans sebagai obejct dari kelas Loan
        var kamus = [Kamus]()
        //akan melakukan perulangan terhadap data json yang di parsing
        do{
            //deklarasikan jsonResult untuk mengambil data jsonnya
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as?
            NSDictionary
            
            //Parse JSON data
            //deklarasi jsonLoans untuk memanggil data array jsonResults yang bernama Loans
            let jsonLoans = jsonResult?["data"] as! [AnyObject]
            //akan melakukan pemanggilan data berulang2 selama jsonLoan memiliki data json array dari variable jsonLoans
            for jsonLoan in jsonLoans{
                //deklarasi loan sebagai objek dari class Loan
                let loan = Kamus()
                loan.kamus_inggris = jsonLoan["kamus_inggris"] as! String
                loan.kamus_idonesia = jsonLoan["kamus_indonesia"] as! String
                
                
                
                kamus.append(loan)
            }
        }catch{
            print(error)
        }
        return kamus
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
