ALTER TABLE dealer ADD FOREIGN KEY (id_company) REFERENCES company (id_company);
ALTER TABLE production ADD FOREIGN KEY (id_company) REFERENCES company (id_company);
ALTER TABLE [order] ADD FOREIGN KEY (id_dealer) REFERENCES dealer (id_dealer);
ALTER TABLE production ADD FOREIGN KEY (id_medicine) REFERENCES medicine (id_medicine);
ALTER TABLE [order] ADD FOREIGN KEY (id_production) REFERENCES production (id_production);
ALTER TABLE [order] ADD FOREIGN KEY (id_pharmacy) REFERENCES pharmacy (id_pharmacy);

SELECT pharmacy.name, [order].date, [order].quantity FROM [order]
	LEFT JOIN pharmacy ON pharmacy.id_pharmacy = [order].id_pharmacy
	LEFT JOIN production ON production.id_production = [order].id_production
	LEFT JOIN company ON company.id_company = production.id_company
	LEFT JOIN medicine ON medicine.id_medicine = production.id_medicine
	WHERE medicine.name = 'Кордерон' AND company.name = 'Аргус'

SELECT medicine.name FROM medicine
	LEFT JOIN production ON production.id_medicine = medicine.id_medicine
	LEFT JOIN company ON company.id_company = production.id_company
	LEFT JOIN [order] ON [order].id_production = production.id_production
	WHERE company.name = 'Фарма' AND production.id_production NOT IN (SELECT [order].id_production FROM [order] WHERE [order].date < '2019-01-25')
GROUP BY medicine.name

SELECT company.name, MIN(production.rating) AS min_rating, MAX(production.rating) AS max_rating FROM production
	LEFT JOIN company ON company.id_company = production.id_company
	LEFT JOIN [order] ON [order].id_production = production.id_production
GROUP BY company.name
HAVING COUNT([order].id_order) >= 120

SELECT dealer.name, pharmacy.name FROM dealer
	LEFT JOIN company ON company.id_company = dealer.id_company
	LEFT JOIN [order] ON [order].id_dealer = dealer.id_dealer
	LEFT JOIN pharmacy ON pharmacy.id_pharmacy = [order].id_pharmacy
 	WHERE company.name = 'AstraZeneca'
ORDER BY dealer.id_dealer

UPDATE production SET production.price = production.price * 0.8
WHERE production.id_production IN (SELECT production.id_production FROM production 
	LEFT JOIN medicine ON medicine.id_medicine = production.id_medicine
	WHERE production.price > 3000 AND medicine.cure_duration <= 7)

CREATE NONCLUSTERED INDEX [IX_dealer_id_company] ON dealer (id_company)
CREATE NONCLUSTERED INDEX [IX_company_name] ON company (name)
CREATE NONCLUSTERED INDEX [IX_medicine_name] ON medicine (name)
CREATE NONCLUSTERED INDEX [IX_production_id_company] ON production (id_company)
CREATE NONCLUSTERED INDEX [IX_production_id_medicine] ON production (id_medicine)
CREATE NONCLUSTERED INDEX [IX_order_id_production] ON [order] (id_production)
CREATE NONCLUSTERED INDEX [IX_order_id_dealer] ON [order] (id_dealer)
CREATE NONCLUSTERED INDEX [IX_order_id_pharmacy] ON [order] (id_pharmacy)
