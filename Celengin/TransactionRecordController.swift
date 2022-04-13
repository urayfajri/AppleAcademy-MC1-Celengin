//
//  TransactionRecordController.swift
//  Celengin
//
//  Created by Kathleen Febiola Susanto on 07/04/22.
//

import UIKit
import CoreData

class TransactionRecordController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var goalName_label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var incomes = [Transaction]()
    var outcomes = [Transaction]()
    var segmentIndex = 0
    var goal: Goals?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Riwayat Transaksi"
        goalName_label.text = goal?.name
        fetchIncome()
        fetchOutcome()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl)
    {
        segmentIndex = sender.selectedSegmentIndex
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchIncome()
        fetchOutcome()
        collectionView.reloadData()
    }
    
    func fetchIncome()
    {
        incomes = []
        var allIncome = [Transaction]()
        let fetchReq: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let pred = NSPredicate(format: "type CONTAINS 'Pemasukan'")
        let sortByDate = NSSortDescriptor(key: "date", ascending: false)
        
        fetchReq.sortDescriptors = [sortByDate]
        fetchReq.predicate = pred
        
        do
        {
            allIncome = try context.fetch(fetchReq)
        }
        
        catch
        {
            
        }
        
        for x in 0..<allIncome.count
        {
            if allIncome[x].goals == goal
            {
                incomes.append(allIncome[x])
            }
        }
    }
    
    func fetchOutcome()
    {
        outcomes = []
        var allOutcome = [Transaction]()
        let fetchReq: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let pred = NSPredicate(format: "type CONTAINS 'Pengeluaran'")
        let sortByDate = NSSortDescriptor(key: "date", ascending: false)
        
        fetchReq.sortDescriptors = [sortByDate]
        fetchReq.predicate = pred
        
        do
        {
            allOutcome = try context.fetch(fetchReq)
        }
        
        catch
        {
            
        }
        
        for x in 0..<allOutcome.count
        {
            if allOutcome[x].goals == goal
            {
                outcomes.append(allOutcome[x])
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if segmentIndex == 0
        {
           return incomes.count
       }
        else
        {
            return outcomes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = (collectionView.dequeueReusableCell(withReuseIdentifier: "income_cv", for: indexPath) as? incomeOutcomeCell)!
        
        if segmentIndex == 0
        {
            cell.iOrO.image = UIImage(systemName: "square.and.arrow.up.fill")
            cell.transactionName.setTitle(incomes[indexPath.row].name, for: .normal)
            cell.money.text = "Rp. \(incomes[indexPath.row].amount)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM YYYY"
            let str_deadline = dateFormatter.string(from: (incomes[indexPath.row].date!))
            cell.date.text = str_deadline
            
            cell.sourceORNeed.text = incomes[indexPath.row].resources
            cell.notes.text = incomes[indexPath.row].notes
        }
        
        else
        {
            cell.iOrO.image = UIImage(systemName: "cart.fill")
            cell.transactionName.setTitle(outcomes[indexPath.row].name, for: .normal)
            cell.money.text = "Rp. \(outcomes[indexPath.row].amount)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM YYYY"
            let str_deadline = dateFormatter.string(from: outcomes[indexPath.row].date!)
            cell.date.text = str_deadline
            
            cell.sourceORNeed.text = outcomes[indexPath.row].resources
            cell.notes.text = outcomes[indexPath.row].notes
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if segmentIndex == 0
        {
            let item = incomes[indexPath.row]
            let sheet = UIAlertController(title: "Ubah", message: nil, preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
            sheet.addAction(UIAlertAction(title: "Ubah", style: .default, handler: {_ in
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "formEditTransaction") as! FormEditTransactionViewController
                vc.transaction = item
                      self.navigationController?.pushViewController(vc, animated: true)
                
            }))
            
            sheet.addAction(UIAlertAction(title: "Hapus", style: .destructive, handler: {[weak self]_ in
                
                item.goals?.progress -= item.amount
                self?.deleteTransaction(item: item)
                collectionView.reloadData()
            }))
            
            present(sheet, animated: true)
        }
        
        else
        {
            let item = outcomes[indexPath.row]
            let sheet = UIAlertController(title: "Ubah", message: nil, preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction(title: "Batal", style: .cancel, handler: nil))
            sheet.addAction(UIAlertAction(title: "Ubah", style: .default, handler: {_ in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "formEditTransaction") as! FormEditTransactionViewController
                vc.transaction = item
                      self.navigationController?.pushViewController(vc, animated: true)
            }))
            
            sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self]_ in
                item.goals?.progress += item.amount
                self?.deleteTransaction(item: item)
                collectionView.reloadData()
            }))
            
            present(sheet, animated: true)
        }
        

    }
    
    func deleteTransaction(item: Transaction)
    {
        context.delete(item)
        
        do
        {
            try context.save()
            fetchIncome()
            fetchOutcome()
        }

        catch
        {

        }
    }
    
    
    
}
